<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>조회2</title>
</head>

<body>
<a href='/board/list' style="list-style: none; text-decoration: none">목록으로 돌아가기</a><br><br><br>
<div>
    <style>
        .pictures {
            max-width:80vw;
        }

        .moreBtn {
            color: darkslategray;
        }
    </style>

    <button class="moreBtn">더보기</button>
<div class="pictures">
    <c:if test="${dto.mainImage != null}">
        <img src="${dto.getMain()}">  <%-- 메소드 호출도 가능하다 --%>
    </c:if>
</div>

</div>

제목: <c:out value="${dto.title}"></c:out><br><br>

작성자: <c:out value="${dto.writer}"></c:out><br><br>

내용: <c:out value="${dto.content}"></c:out>
<br><br>


<hr>
<div>
    <div>
        <input type="text" name="replyText" value="샘플 댓글">
    </div>
    <div>
        <input type="text" name="replier" value="testUser">
    </div>
    <div>
        <button class="addReplyBtn">댓글 추가</button>
    </div>
</div>
<br><br>
<hr>


<div>
    <h3>댓글 수정 모달 </h3>
    <div>
        <input type="text" name="modReplyText" >
    </div>
    <div>
        <input type="text" name="modReplier" readonly>
    </div>
    <div>
        <button class="modReplyBtn">댓글 수정</button>
        <button class="removeReplyBtn">댓글 삭제</button>
    </div>
</div>

<hr>

<ul class="replyUL"><%-- 댓글 --%>
</ul>
<ul class="pageUL"><%-- 댓글 페이징 --%>
</ul>

<%-- Axios --%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    /* 실패하는 부분 고려하려면 catch 문 사용하면 된다. then().catch() */
    document.querySelector(".moreBtn").addEventListener("click", (e) => {

        axios.get("/board/files/${dto.bno}").then(
            res => {
                console.log(res.data)
                const arr = res.data
                let str= ""
                for(let i= 0;i < arr.length; i++){
                    str += `<img src='/view?fileName=\${arr[i].link}'>`
                }
                console.log(str)
                document.querySelector(".pictures").innerHTML = str
            }
        )

    }, false)

</script>
<script>
//--------------------------------------------------------------------
    let initState = {
        bno: ${dto.bno},
        replyArr:[],
        replyCount:0,
        size:10,
        pageNum:1
    }

    const replyUL = document.querySelector(".replyUL")
    const pageUL = document.querySelector(".pageUL")

    pageUL.addEventListener("click",(e) => {
        if(e.target.tagName != 'LI'){
            return
        }
        const dataNum = parseInt(e.target.getAttribute("data-num"))
        replyService.setState({pageNum:dataNum})

    }, false)

    document.querySelector(".addReplyBtn").addEventListener("click",(e)=> {

        const replyObj = {
            bno: ${dto.bno},
            replyText: document.querySelector("input[name='replyText']").value,
            replier:document.querySelector("input[name='replier']").value
        }

        replyService.addServerReply(replyObj)

    }, false)

    const modReplyTextInput = document.querySelector("input[name='modReplyText']")
    const modReplierInput = document.querySelector("input[name='modReplier']")
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
        modReplierInput.value = replyObj.replier
        removeReplyBtn.setAttribute("data-rno", rno)

    }, false)

    removeReplyBtn.addEventListener("click", (e) => {

        const rno = parseInt(e.target.getAttribute("data-rno"))

        replyService.removeServer(rno).then(result => {
           //console.log(targetLi)
            targetLi.innerHTML ="DELETED"
        })

    }, false)


    function render(obj){

        //console.log("render................")
        //console.dir(obj)

        function printList(){
            const arr = obj.replyArr

            replyUL.innerHTML = arr.map(reply =>
                                <!-- 빽틱 을 쓰면 줄바꿈을 해도 계속 유지가 된다. -->
                                `<li>\${reply.rno} ||
                                    <div> \${reply.replyText}</div>
                                    <button data-rno=\${reply.rno} class='modBtn'>수정</button>
                                </li>`).join(" ")
        }

        function printPage(){

            const currentPage = obj.pageNum
            const size = obj.size

            let endPage = Math.ceil(currentPage/10) * 10
            const startPage = endPage - 9

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
    const replyService = (function(initState, callbackFn){

        let state = initState
        const callback = callbackFn

        const setState = (newState)=> {
            state = {...state, ...newState}
           // console.log(state)
            //전개연산자를 이용하여 스테이트 상태값을 변경시키기

            //여기서 비동기를 들어가서 자동으로 바뀌도록 하자!
            //console.log(state)

            //newState 안에 replyCount 값 속성이나 pageNum 속성이 있다면!
            if(newState.replyCount || newState.pageNum){
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
            //console.log(res.data)

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

            const res = await axios.delete(`/replies/\${rno}`)

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

