const replyService = (function (){

    const addReply = async function (replyObj, callback){
        console.log("addReply...............")

        const res = await axios.post("/replies/", replyObj)
        callback()
    }

    const getList = async function ({bno,page,size}, callback){
        console.log("getList...............")

        //this.page = page || 1; 이건 안되나

        const parameter = {page:page||1, size:size||10}

        //axios 와 관련된 것은 전부 이쪽으로 빼고 싶어!
        const res = await axios.get(`/replies/list/${bno}`,{params: parameter })

        //console.log(res.data)
        callback(res.data)
        //콜백 지옥이라는 문제점이 생길 수 있다....
    }

    return {addReply, getList}

})(); //즉시 실행 함수
//closer 연습
//모듈 패턴 - 함수를 모아서 하나의...


const qs = function (str){
    return document.querySelector(str)
}

const qsAddEvent = function (selector, type, callback){
    const target = document.querySelector(selector)
    target.addEventListener(type, callback, false)
    //제이쿼리는 타겟을 리턴함. 여기는 안해도 돼
}