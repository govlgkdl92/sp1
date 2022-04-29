const replyService = (function (){
    let replyCountFn;

    const setReplyCount = function(fn){
        replyCountFn = fn
    }

    const addReply = async function (replyObj, size, callback){
        console.log("addReply...............")

        const res = await axios.post("/replies/", replyObj)
        console.log(res.data);
        const replyCount = parseInt(res.data.result)
        console.log(replyCount);
        console.log("-------------add")

        //console.log(res.data)
        //1. addReply를 호출할 때마다 bno와 size를 받자
        //2. 아예 처음부터 Reply.js 에다가 모듈 패턴을 구성하면서 데이터를 유지할 수 있도록 하자.
        //   -> reply.js에서 쓸 일이 많은 거 같아! 아예 인스탄스로 선언하는 것도 괜찮을 거 같다.

        // setReplyCount 가 function이 아니라는 오류가 났어.... 왜?
        //console.log(setReplyCount)
        //console.log("rely function 확인")
        //setReplyCount = undefined? 왜??

        replyCountFn(replyCount)
        //setReplyCount(replyCount) //인스탄스 벨리어블 처럼 만들고 싶어...

        const bno = replyObj.bno
        const page = Math.ceil(replyCount/size)

        callback({bno, page, size})
    }

    const getList = async function ({bno,page,size}, callback){
        console.log("getList...............",bno,page,size )
        //this.page = page || 1; 이건 안되나
        const parameter = {page:page||1, size:size||10}

        //axios 와 관련된 것은 전부 이쪽으로 빼고 싶어!
        const res = await axios.get(`/replies/list/${bno}`,{params: parameter })

        //console.log(res.data)
        callback(res.data)
        //콜백 지옥이라는 문제점이 생길 수 있다....
    }
    return {addReply, getList, setReplyCount}

})()
//즉시 실행 함수
//closer 연습
//모듈 패턴 - 함수를 모아서 하나의...

const qs = function (str){
    return document.querySelector(str)
}

const qsAddEvent = function (selector, type, callback, tagName){
    const target = document.querySelector(selector)
    if(!tagName){
        target.addEventListener(type, callback, false)
        //제이쿼리는 타겟을 리턴함. 여기는 안해도 돼
    }else{
        target.addEventListener(type, (e) => {
            const realTarget = e.target
            if(realTarget.tagName !== tagName.toUpperCase()){
                return
            }
            callback(e, realTarget)
        }, false)
    }

}

//js 파라미터의 함수의 영향을 안받는다.! 위에랑 합쳐 볼까?
//const qsTossEvent = function (selector, type, callback, tagName){
//}