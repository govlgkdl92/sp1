<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>조회</title>
</head>
<body>
${listDTO}
${dto}

<div>
<button class="listBtn">목록</button>
<button class="modBtn">수정</button>
</div>

<script>
    const bno = ${dto.bno}

    document.querySelector(".listBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()

        self.location = `/board/list${listDTO.link}`

    }, false)


    document.querySelector(".modBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()

        self.location = `/board/modify/${bno}${listDTO.link}`

    }, false)

</script>
</body>
</html>
