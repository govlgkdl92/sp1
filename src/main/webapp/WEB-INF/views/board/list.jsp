<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>목록</title>
</head>
<body>
<%--<h3>${listDTO}</h3>--%>
  <%--앞 부분 소문자로 !!--%>

<div class="searchDiv">
    <select class="type">
        <option value="">---</option>
        <option value="t"    ${listDTO.type == "t" ? "selected" : ""}>제목</option>
        <option value="tc"   ${listDTO.type == "tc" ? "selected" : ""}>제목,내용</option>
        <option value="tcw"  ${listDTO.type == "tcw" ? "selected" : ""} >제목,내용,작성자</option>
    </select>
    <input type="text" name="keyword" value="${listDTO.keyword}">
    <button class="searchBtn">Search</button>
</div>

<ul class="dtoList">
    <c:forEach items="${dtoList}" var="board">
        <li>
            <span>${board.bno}</span>
            <span><a href='/board/read/${board.bno}' class="dtoLink"><c:out value="${board.title}"/></a></span>
            <%-- ↓ 예전 방식 --%>
           <%-- <span><a href='/board/read/${listDTO.link}&bno=${board.bno}'>${board.title}</a></span>--%>
            <span><c:out value="${board.writer}"/></span>
            <c:if test="${board.replyCount != 0}">
            <span><c:out value="[${board.replyCount}]"/></span></c:if>
        </li>
    </c:forEach>
</ul>

${pageMaker}

${listDTO}

<style>
    .pagination{
        display: flex;
    }
    .pagination .page-item {
        margin : 0.4em;
        list-style:none;
    }
</style>

<ul class="pagination">

    <li class="page-item disabled">
        <a class="page-link" href="${pageMaker.start-1}"><</a>
    </li>
    <c:forEach begin="${pageMaker.start}" end ="${pageMaker.end}" var="num">
    <li class="page-item"><a class="page-link" href="${num}">${num}</a></li>
    </c:forEach>

    <li class="page-item">
        <a class="page-link" href="${pageMaker.end+1}">></a>
    </li>
</ul>

<form class="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${listDTO.page}">
    <input type="hidden" name="size" value="${listDTO.size}">
    <input type="hidden" name="type" value="${listDTO.type == null ? '':listDTO.type}">
    <input type="hidden" name="keyword" value="${listDTO.keyword == null ? '' : listDTO.keyword}">
</form>

<script>


    const linkDiv = document.querySelector(".pagination")
    //console.log(linkTage)
    const actionForm = document.querySelector(".actionForm")

    // 만약 jquery 사용한다면 순수하게 돔을 쓰는게 아니라 함수를 통해 돔으로 간다 그래서 상대적으로 느릴 수 있음
    document.querySelector(".dtoList").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const target = e.target
        if(target.getAttribute("class").indexOf('dtoLink') < 0 ){
            return                  // class 는 이름이 길어질 수 있으므로 indexOf 그 안에 dtoLink가 있는 지 확인 하는 방식으로 가야함.
        }
        const url = target.getAttribute("href")

        actionForm.setAttribute("action", url)
        actionForm.submit()
    }, false)


    linkDiv.addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()

        const target = e.target

        if(target.getAttribute("class") !== 'page-link'){ //page 링크가 아니면 끝내기
            return
        }

        const pageNum = target.getAttribute("href")
        //alert(pageNum) //경고창은 위험하므로 웬만하면 하지 말자.
        actionForm.querySelector("input[name='page']").value = pageNum
        actionForm.setAttribute("action","/board/list")
        actionForm.submit();

    }, false)
      // ↑ 버블링만 할 거다. 캡쳐링을 false다 라는 뜻



    //서치
    document.querySelector(".searchBtn").addEventListener("click", (e) =>{

        const type = document.querySelector('.searchDiv .type').value
        const keyword = document.querySelector(".searchDiv input[name='keyword']").value

        console.log(type, keyword)

        actionForm.setAttribute("action","/board/list")
        actionForm.querySelector("input[name='page']").value = 1
        actionForm.querySelector("input[name='type']").value = type
        actionForm.querySelector("input[name='keyword']").value = keyword
        actionForm.submit()
    },false)

    /* java script에서 배열을 루프 돌리는 법 */

    /* var 변수는 요즘 사용 안함. */
    /* const, lat 을 많이 사용  */
    const result = '${result}'  /* 세미콜론 안붙여도 됨 */

    console.log(result)

    if(result !== ''){
        alert("처리되었습니다.")
    }

</script>
</body>
</html>






<%--
예전 스타일  for루프.. 별로...
const linkTage = document.querySelectorAll(".page-link")
//console.log(linkTage)
const actionForm = document.querySelector(".actionForm")

//
for(const tag of linkTage){
//console.log(tag)
tag.addEventListener("click",(e) => {
e.preventDefault();
//console.log(tag.href)
//console.log(tag.getAttribute("href"))

const pageNum = tag.getAttribute("href") //페이지 번호

actionForm.querySelector("input[name='page']").value = pageNum;
actionForm.submit()
}, false)
} --%>
