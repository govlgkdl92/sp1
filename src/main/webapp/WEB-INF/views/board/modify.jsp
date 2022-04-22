<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>modify</title>
</head>
<body>

${listDTO}
${dto}

<form class="modForm" action="/board/modify/${dto.bno}" method="post">
    <%-- 정석 적인 방법 listDTO 히든 타입으로 보내기 --%>
    <input type="hidden" name="page" value="${listDTO.page}">
    <input type="hidden" name="size" value="${listDTO.size}">
    <input type="hidden" name="type" value="${listDTO.type}">
    <input type="hidden" name="keyword" value="${listDTO.keyword}">
<div>
    <div>
        <input type="text" name="bno" value="<c:out value="${dto.bno}"/>" readonly>
    </div>
    <div>
        <input type="text" name="title" value="<c:out value="${dto.title}"/>">
    </div>
    <div>
        <textarea name="content"><c:out value="${dto.content}"/></textarea>
    </div>
</div>
</form>

<div>
    <button class="listBtn">목록</button>
    <button class="modPostBtn">수정완료</button>
    <button class="delPostBtn">삭제</button>
</div>

<form class="actionForm" action="/board/modify/{bno}" method="post">
    <input type="hidden" name="bno" value="${dto.bno}">
</form>

<script>
    function sQuery(expression){
        return document.querySelector(expression)
    }

    const bno = ${dto.bno}
    const actionForm = sQuery(".actionForm")

    sQuery(".listBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()

        self.location = `/board/list${listDTO.link}`

    }, false)

    /* 예전에는 jquery를 사용했으나 사용 안하고 해볼 것!! */

    sQuery(".delPostBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()
        actionForm.setAttribute("action", `/board/remove/${bno}`)
        actionForm.submit();

    }, false)

    //수정 완료 버튼
    sQuery(".modPostBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()
        sQuery(".modForm").submit();

    }, false)

</script>

</body>
</html>