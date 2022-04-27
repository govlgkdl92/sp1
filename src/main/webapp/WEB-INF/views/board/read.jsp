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
<script>

    //댓글 등록
    document.querySelector(".addReplyBtn").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const replyTextInput = document.querySelector("input[name='replyText']")
        const replyerInput = document.querySelector("input[name='replyer']")

        const replyText = replyTextInput.value
        const replyer = replyerInput.value

        const reply = {bno, replyText, replyer}

        //값이 잘 들어갔는 지 확인 하자
        //console.log(reply)

        //async 로 보내자
        sendPost(reply)

    }, false)


    async function sendPost(reply){
        const res = await axios.post(`/replies/`, reply)

        console.log(res)
    }

    //댓글 리스트
    /* async 비동기  await 호출 될 때까지 기다리기  */
    /* 댓글 axios 사용*/
    async function getReplyList(bno){
    /*  ↓ then() 사용시 여기에 return을 바로 넣으면 promise 값이 호출된다.    */
        try{
            const res = await axios.get(`/replies/list/${bno}`)
            // .then(res => res.data)

            const data = res.data;
            //console.log(data)

            // await axios.post('/xxx', ...) 동기화된 함수를 만들어내는 것 처럼 만들어볼 수 있음.

            /* 함수 내에 await 가 있으면 반드시 async 가 선언되야 한다.
               await 를 사용하면 동기화된 처리 처럼 사용할 수 있다.
               그러나 이상태에서 return 을 해도 promise 가 나온다.
               비동기 처리는 return 이 무조건 promise!!!! 이기 때문에..
               async await 는 함수를 만들 때 약간 동기화된 코드 처럼 작동하는 것 뿐이지 내부에서 진짜 동기화가
               된 것은 아니기 때문에.. 비동기 처리이므로 반환은 무조건 promise!
               비동기 함수의 모든 return 은 promise 다.           */

            return data
        }catch(err){
            return err
        }
    }

    const bno = ${dto.bno}

    getReplyList(bno)
        .then(arr =>{
            const liStr = arr.map(replyDTO => `<li>\${replyDTO.rno}|| \${replyDTO.replyer} || \${replyDTO.replyText}</li>`).join(" ")
            document.querySelector(".replyUL").innerHTML = liStr
        })
        .catch(err => console.log(err))
    // 리액트에서 많이 쓰이는 코드 스타일..


    /* ajax 통신이 되는 지 확인 */
    getReplyList(bno)


    /* 리스트 목록 */
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
