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
    <ul class="replyUL">

    </ul>
</div>



<div>
    <div>
        내용 <input type="text" name="replyText" value="개발 테스트 샘플">
    </div>
    <div>
        작성자 <input type="text" name="replyer" value="ys test">
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
    const replyCount = ${dto.replyCount}

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

    getServerList()

    function getServerList() {
        replyService.getList({bno}, (replyArr) => {
               const liArr = replyArr.map(reply => `<li>\${reply.replyer} || \${reply.replyText}</li>`)
               replyUL.innerHTML = liArr.join(" ")}
        )
    }




    function addServerReply(){

        replyService.addReply({
                bno:bno,
                replyText:qs("input[name='replyText']").value,
                replyer:qs("input[name='replyer']").value
            },
            () => {
                /*alert("댓글이 등록되었습니다.")*/
                getServerList()
            }
        )
    }

    //댓글추가
    qsAddEvent(".addReplyBtn", "click", addServerReply)



</script>
</body>
</html>
