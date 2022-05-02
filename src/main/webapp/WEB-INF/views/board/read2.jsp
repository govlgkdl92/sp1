<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>조회2</title>
</head>

<body>
<c:out value="${dto.title}"></c:out><br><br>

<textarea readonly><c:out value="${dto.content}"></c:out></textarea>
<br><br>

<ul class="replyUL"><%-- 댓글 --%>
</ul>
<ul class="pageUL"><%-- 댓글 페이징 --%>
</ul>

<div>
    <div>
        내용 <input type="text" name="replyText" value="지금은 테스트..">
    </div>
    <div>
        작성자 <input type="text" name="replyer" value="hello">
    </div>
    <div>
        <button class="addReplyBtn">등록</button>
    </div>
</div>
<br><br>
<div>
    <h3>댓글 수정 모달</h3>
    <div>
        내  용 <input type="text" name="modReplyText">
    </div>
    <div>
        작성자 <input type="text" name="modReplyer" readonly>
    </div>
    <div>
        <button class="modReplyBtn">수정</button>
        <button class="removeReplyBtn">삭제</button>
    </div>
</div>

<%-- Axios --%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>


//--------------------------------------------------------------------
    let initState = {
        bno : ${dto.bno},
        replyArr : [],
        replyCount : 0,
        size : 10,
        pageNum : 1
    }

    const replyUL = document.querySelector(".replyUL")
    const pageUL = document.querySelector(".pageUL")

    pageUL.addEventListener("click", (e) => {
        if(e.target.tagName != 'LI'){
            return
        }
        const dataNum = parseInt(e.target.getAttribute("data-num"))
        replyService.setState({pageNum:dataNum})
    }, false)

    document.querySelector(".addReplyBtn").addEventListener("click", (e) => {
        const replyObj = {
            bno: ${dto.bno},
            replyText: document.querySelector("input[name='replyText']").value,
            replyer:document.querySelector("input[name='replyer']").value
        }

        replyService.addServerReply(replyObj)

    },false)

    const modReplyTextInput = document.querySelector("input[name='modReplyText']")
    const modReplyerInput = document.querySelector("input[name='modReplyer']")
    const removeReplyBtn = document.querySelector(".removeReplyBtn")

    let targetLi;

    replyUL.addEventListener("click", (e) => {
        if(!e.target.getAttribute("data-rno")){
            return;
        }

        targetLi = e.target.closest("li")
        const rno = parseInt(e.target.getAttribute("data-rno"))

        const replyObj = replyService.findReply(rno)
        modReplyTextInput.value = replyObj.replyText
        modReplyerInput.value = replyObj.replyer
        removeReplyBtn.setAttribute("data-rno", rno)

    },false)

    removeReplyBtn.addEventListener("click", (e) => {
        const rno = parseInt(e.target.getAttribute("data-rno"))

        replyService.removeServer(rno).then(result => {
            console.log(targetLi)
            targetLi.innerHTML = "삭제된 댓글입니다."
        })
    }, false)

    function render(obj){
        //console.dir(obj)
        //console.log("render.....")

        function printList(){
            const arr = obj.replyArr
            replyUL.innerHTML = arr.map(reply =>
                                <!-- 빽틱 을 쓰면 줄바꿈을 해도 계속 유지가 된다. -->
                                `<li>
                                    <div>\${reply.replyer}||
                                          \${reply.replyText}
                                        <button data-rno=\${reply.rno} class='modBtn'>수정
                                        </button>
                                    </div>
                                 </li>`).join(" ")
        }

        function printPage(){
            const currentPage = obj.pageNum
            const size = obj.size

            let endPage = Math.ceil(currentPage/10)*10
            const startPage = endPage-9;

            //이전 페이지 startPage가 1이 아니면 보이기
            const prev = startPage != 1
            endPage = obj.replyCount < endPage * obj.size? Math.ceil(obj.replyCount/obj.size) : endPage

            //다음 페이지
            //endPage * obj.size가 replyCount 보다 크다면 다음페이지 존재
            const next = obj.replyCount > endPage * obj.size

            //console.log("startPage:",startPage, "endPage",endPage, "currentPage",currentPage)
            let str = ''
            if(prev){
                str += `<li data-num=\${startPage-1}>이전</li>`
            }
            for(let i = startPage; i <= endPage; i++){
                if(i===currentPage){
                    str += `<li data-num=\${i} style="color:#e54545; cursor:default">\${i}</li>`
                }else{
                    str += `<li data-num=\${i}>\${i}</li>`
                }

            }
            if(next){
                str += `<li data-num=\${endPage+1}>다음</li>`
            }

            pageUL.innerHTML = str

        }

        printList()
        printPage()
    }

//---Aios 통신 부분-----------------------------------------------------------------

    //즉시 실행 함수
    //const replyService = (function () {
        //모듈 패턴
    //})

    //오늘은 그냥 객체로
    const replyService = (function (initState, callbackFn){
        let state = initState
        const callback = callbackFn

        const setState = (newState)=> {
            state = {...state, ...newState} //전개연산자를 이용하여 스테이트 상태값을 변경시키기

            //여기서 비동기를 들어가서 자동으로 바뀌도록 하자!
            //console.log(state)

            //newState 안에 replyCount 값 속성이나 pageNum 속성이 있다면!
            if(newState.replyCount || newState.pageNum ){
                //서버의 데이터를 가져와야만 한다
                getServerList(newState)
            }

            callback(state)
        }

        async function getServerList(newState){

            let pageNum
            //setState가 아니다 setState를 하게 되면 랜더링이 일어나고, 이건 그냥 내부값을 바꾸는 것...
            //replyCount.. 지금처럼 하면 ... 나중에 댓글 삭제 할 때 문제가 될 거야...

            if(newState.pageNum){
                pageNum = newState.pageNum
            }else{
                pageNum = Math.ceil(state.replyCount/state.size)
            }

            const paramObj = {page:pageNum, size:state.size}
            const res = await axios.get(`/replies/list/\${state.bno}`, {params: paramObj})
            console.log(res.data)

            //pageNum setState의 넘기면 안돼...

            state.pageNum = pageNum
            // 일단 수동으로 수정

            setState({replyArr:res.data})
            //호출이 되는 지 확인

        }

        //View 를 하는데 있어서 model 데이터 ViewModel

        async function addServerReply(replyObj){
            const res = await axios.post(`/replies/`, replyObj)
            const data = res.data
            //console.log("addReplyResult:",data)

            setState({replyCount: data.result})
        }

        function findReply(rno){
            return state.replyArr.find(reply => reply.rno === rno)
        }

        async function removeServer(rno){
            const res = await axios.delete(`/replies/\${rno}`);

            //success
            const result = res.data.result
            return result
        }

        return {setState, addServerReply, findReply ,removeServer}

    })(initState, render)
       /* state: initState,

        setState : function(changedState, callback){
            console.log("changeState: ",changedState)
            state = {...state, changedState}
            console.log(state)
                    // {... 전개 연산자

        },
        getServerList: function(){
        여기서 디스를 추가해야한다.
        }*/


    replyService.setState({replyCount: ${dto.replyCount}})
//페이지 카운트나 리플라이가 바뀌면 랜더가 새로 일어난다!
    //replyService.setState({pageNum: 11})
//호출을 많이 하는 단점이 좀 있다...

</script>

<style>
    .replyUL{
        list-style: none;
    }

    .pageUL{
        list-style: none;
        display:flex;
    }

    .pageUL li{
        list-style: none;
        margin : 0.2em;
        border: 1px solid;
        cursor: pointer;
    }

</style>
</body>
</html>

