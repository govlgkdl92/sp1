<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>목록</title>
</head>
<body>
<h3>${listDTO}</h3>
  <%--앞 부분 소문자로 !!--%>
${listDTO.link}
<hr/>
${pageMaker}
<ul>
    <c:forEach items="${dtoList}" var="board">
        <li>
            <span> ${board.bno}</span>
            <span><a href='/board/read${listDTO.link}&bno=${board.bno}'>${board.title}</a></span>
            <span> ${board.writer}</span>
        </li>
    </c:forEach>

</ul>

<script>
    /* var 변수는 요즘 사용 안함. */
    /* const, lat 을 많이 사용  */
    const result = '${result}'  /* 세미콜론 안붙여도 됨 */

    console.log(result)

    if(result !== ''){
        alert("등록 완료")
    }

</script>
</body>
</html>
