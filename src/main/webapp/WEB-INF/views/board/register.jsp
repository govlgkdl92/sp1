<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>등록</title>
</head>
<body>
    <h1>Register Page</h1><a href='/board/list' style="list-style: none; text-decoration: none">목록으로 돌아가기</a><br><br><br>

    <form class="actionForm" name="board" action="/board/register" method="post">
        <label>제 목</label><input type="text" name="title"/><br><br>
        <label>작성자</label><input type="text" name="writer" value="파일업로드"/><br><br>
        <label>내 용</label><input type="text" name="content" value="파일업로드"/>

        <%-- 독립적인 DB 시 - 메인 이미지(섬네일) 들어가야 함--%>

        <%-- 게시판에 종속적인 DB 등록시 - 첨부파일 데이터도 같이 입력해서 등록해야 함
                                    - 보통 파일은 여러개 임으로 배열로 받는 것이 좋다.
                                      ex) fileDTO[]

   <%--  이미지 등록이 이런식으로 들어가야 함. 서블릿 돌 때 해야해!
        <input type="hidden" name="uploads[0].uuid" value="aaa">
````--%>

        <button type="button" class="formBtn">등록하기</button>
        <div class="hiddenClass"></div>
    </form>

<%-- 전통적인 파일 업로드 방식 --%>
<h4>파일 업로드 테스트</h4>
                                            <%-- 이미지 첨부시 반드시 멀티파트 타입 지정해줘야 한다.--%>
<form action="/upload1" method="post" enctype="multipart/form-data">
                        <%-- 이름은 파라미터 타입의 이름과 맞춰줘야 한다. --%>
    <input type="file" name="files" multiple>
                                    <%-- multiple은 동시에 한번에 업로드가 가능하다 --%>
    <button>Upload</button>

    <%-- 리액트, axios 들어가니까.. jQuery가 아닌 Vanila.js를 사용했다.
        jQuery는 함수 / 함수를 실행하면 결과가 나오는데..

     --%>
</form>
<br><br>

    <div>
        <h2> Ajax Upload</h2>
        <div class="uploadInputDiv">
            <input type="file" name="upload" multiple class="uploadFile">
        </div><br><br>
            <button class="uploadBtn">Ajax Upload</button>
    </div>

    <style>
        .uploadResult{
            display: flex;
        }

        .uploadResult > div {
            margin:3vm;
            border-color: sienna;
            /*   자동으로 줄 바꾸는 것 넣기 */
        }

        .delBtn{
            cursor: pointer;
            border-style: none;
        }
    </style>

    <div class="uploadResult">
    </div>

<%-- Axios --%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    const uploadResult = document.querySelector(".uploadResult")
    const cloneInput = document.querySelector(".uploadFile").cloneNode()


    //등록 버튼 눌렀을 시
    document.querySelector(".formBtn").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const divArr = document.querySelectorAll(".uploadResult > div")
        let str = "";

        for(let i= 0;i < divArr.length; i++){
            const fileObj = divArr[i]

            if(i === 0){
                const mainImageLink = fileObj.querySelector("img").getAttribute("src")
                str += `<input type='hidden' name='mainImage' value='\${mainImageLink}'>`
            }

            const uuid = fileObj.getAttribute("data-uuid")
            const img = fileObj.getAttribute("data-img")
            const savePath = fileObj.getAttribute("data-savepath")
            const fileName = fileObj.getAttribute("data-filename")

            str += `<input type='hidden' name='uploads[\${i}].uuid' value='\${uuid}'>`
            str += `<input type='hidden' name='uploads[\${i}].img' value='\${img}'>`
            str += `<input type='hidden' name='uploads[\${i}].savePath' value='\${savePath}'>`
            str += `<input type='hidden' name='uploads[\${i}].fileName' value='\${fileName}'>`
        }//for

        const actionForm =  document.querySelector(".actionForm")
        document.querySelector(".hiddenClass").innerHTML += str
        //console.log("actionForm.innerHTML :" + actionForm.innerHTML)

        actionForm.submit();


    },false)

    uploadResult.addEventListener("click", (e) => {

        if(e.target.getAttribute("class").indexOf("delBtn") < 0){
            return
        }
        const btn = e.target
        const link = btn.getAttribute("data-link")

        deleteToServer(link).then(result => {
            btn.closest("div").remove()
        })
        //
        // axios 는 promise 반환...

    },false)



    document.querySelector(".uploadBtn").addEventListener("click",(e)=> {

        const formObj = new FormData();
        const fileInput = document.querySelector(".uploadFile")
        //console.log(fileInput.files)

        const files = fileInput.files

        for (let i = 0; i < files.length; i++) {
            //console.log(files[i])
            formObj.append("files", files[i]);
            //console.log(files[i])
        }
                                //resultArr 은 uploadResultDTO

                                            //구조 분해 할당 (리액트에서 할 개념)
                                            //안에 있는 배열의 변수를 한꺼번에 변수로 쪼갤 수 있다.
                                            //result -> {uuid,thumbnail,link,fileName} 이런식으로 해도 결과가 같음.
        uploadToServer(formObj).then(resultArr => {
            uploadResult.innerHTML += resultArr.map( ({uuid,thumbnail,link,fileName,savePath, img}) => `
                <div data-uuid='\${uuid}' data-img='\${img}'  data-filename='\${fileName}'  data-savepath='\${savePath}'>
                <img src='/view?fileName=\${thumbnail}'>
                <button data-link='\${link}' class="delBtn">x</button>
                \${fileName}</div>`).join(" ")

            fileInput.remove()
            document.querySelector(".uploadInputDiv").appendChild(cloneInput).cloneNode()
                                                                //업로드 버튼을 눌렀을 때 그제서야 버튼을 찾기 때문에 이렇게 하는 게 가능
                                                                //업로드 버튼을 누르면 dom 이 복구된 상태에서 찾기 때문에 읽을 수 있다.
        })

    },false)




    //업로드 된 이미지 삭제
    async function deleteToServer(fileName){
        //axios 의 장점은 기본이 다 json 처리다.
        const options = {headers: { "Content-Type": "application/x-www-form-urlencoded"}}

        const res = await axios.post("/delete", "fileName="+fileName, options )

        //console.log(res.data)

        return res.data

    }

    //이미지 업로드
    async function uploadToServer (formObj) {

        //console.log("upload to server......")
        //console.log(formObj)

        const response = await axios({
            method: 'post',
            url: '/upload1',
            data: formObj,
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });

        return response.data
    }
    /* 어싱크 함수의 모든 반환은 프라미스다*/

</script>


</body>
</html>
