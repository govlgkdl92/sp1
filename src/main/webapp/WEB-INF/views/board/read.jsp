<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>조회</title>
</head>
<body>
<%--${listDTO}
${dto}--%>
<br><br><br>

<c:out value="${dto.title}"></c:out><br><br>

<textarea readonly><c:out value="${dto.content}"></c:out></textarea>
<br>
<div>
<br>
<button class="listBtn">목록</button>
<button class="modBtn">수정</button>
</div>

<div>
    <h4 class="totalReplyCountShow"></h4>
    <ul class="replyUL">

    </ul>

    <style>
        .pageUL{
            display:flex;
        }

        .pageUL li{
            list-style: none;
            margin : 0.1em;
            border: 1px solid;
        }

    </style>
    <ul class="pageUL">

    </ul>
</div>



<div>
    <div>
        내용 <input type="text" name="replyText" value="지금은 테스트..">
    </div>
    <div>
        작성자 <input type="text" name="replier" value="hello">
    </div>
    <div>
        <button class="addReplyBtn">등록</button>
    </div>
</div>


<%-- Axios --%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
//js 파일 가져오기
<script src="/resources/js/reply.js"></script>
<script>

    const bno = ${dto.bno}
    const replyUL = qs(".replyUL") //document.querySelector() 줄임
    const pageUL = qs(".pageUL")

    let replyCount = ${dto.replyCount}

    console.log("replyCount: " + ${dto.replyCount})

    replyService.setReplyCount(function (num){
        //넘버값은 바꼈지만 렌더링 하지 않았을 뿐...
        //모듈, 클로져를 이용해서 함수로 데이터를 이동할 수 있다더라
        replyCount = num
        console.log("-----set reply count new value : "+num)
        qs(".totalReplyCountShow").innerHTML=replyCount
        printPage()
    })

    //console.log("======================================")
    //console.log(replyService)

    const pageNum = 1
    const pageSize = 10

    //console.log(replyService)

    //코드를 깔끔하게 짜는 게 목표!
    //비동기 처리 , 콜백
    //replyService.getList(bno, printReplies)
    //function printReplies(replyArr){
    //    const liArr = replyArr.map(reply => `<li>AAA</li>`)
    //    replyUL.innerHTML = liArr.join(" ")
    //}

    //replyService.getList(bno, (replyArr) => {
    //    const liArr = replyArr.map(reply => `<li>AAA</li>`)
    //    replyUL.innerHTML = liArr.join(" ")
    //}) //이 코드를 밑에 addReply에 추가하라 수 있지 않을까?

    function printPage(targetPage){

        const lastPageNum = Math.ceil(replyCount/pageSize)

        let endPageNum = Math.ceil((targetPage||lastPageNum)/10) * 10
        const startPageNum = endPageNum - 9

        endPageNum = lastPageNum < endPageNum ? lastPageNum : endPageNum

        console.log("targetPage ", targetPage, "lastPageNum ", lastPageNum)
        const current = targetPage ? parseInt(targetPage) : lastPageNum;

        //console.log("pageParam: "+pageParam)

        let str = '';

        if(startPageNum > 1){
            str += `<li data-num="\${startPageNum-1}">\${startPageNum-1} 이전</li>`
        }

        for(let i = startPageNum; i<=endPageNum; i++){
            str += `<li data-num="\${i}" class="\${i===current?current:''}">[\${i}]</li>`
        }

        if(lastPageNum > endPageNum){
            str += `<li data-num="\${endPageNum+1}">\${endPageNum+1} 다음</li>`
        }

        pageUL.innerHTML = str

    }


    function getServerList(param) {
        replyService.getList(param, (replyArr) => {
               const liArr = replyArr.map(reply => `<li>\${reply.replier} || \${reply.replyText}</li>`)
               replyUL.innerHTML = liArr.join(" ")
               printPage(param.page)
        })
    }

    function addServerReply(){

        replyService.addReply(
                {bno:bno,
                replyText:qs("input[name='replyText']").value,
                    replier:qs("input[name='replier']").value },
            pageSize,
            (param) => {
                // alert("댓글이 등록되었습니다.")
                // 댓글 등록 후 다시 조회, 방금 등록한 댓글이 나오도록 마지막 페이지...
                getServerList(param)
            }
        )
    }

    //댓글추가
    qsAddEvent(".addReplyBtn", "click", addServerReply)
    qsAddEvent(".pageUL", "click", (evt, realTarget) => {
        getServerList({bno:bno, page:num, size:pageSize})
    })

    //댓글 페이징


    //로딩이 다 된 후 getServerList()를 호출해야 해!
    //after loading
    const pageParam = Math.ceil(replyCount/pageSize);
    //console.log(pageParam)

    //조회 시 바로 현재 댓글 보이도록
    getServerList({bno:bno, page:pageParam, size:pageSize})
    //즉시실행함수를 넣어주면 좀 더 우아하게 코딩을 짤 수 있다~


</script>
</body>
</html>
