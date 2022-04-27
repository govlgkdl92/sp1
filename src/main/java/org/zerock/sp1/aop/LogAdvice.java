package org.zerock.sp1.aop;


import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import java.util.Arrays;

//aop @Aspect 바로 안보이네? aop 라이브러리는 있는데... 환경설정을 하자!
//검색해 보니 import org.aspectj.lang.annotation.Aspect
//spring이 아닌 aspectj 안에 있구나 aspectj 라이브러리를 추가하자
//라이브러리 추가 해도 안걸리네...?
//RuntimeOnly 이기 때문에... 막 쓰기 위해 implementation로 바꿔줌
//root-context 에 aop component-scan 추가


@Aspect
@Log4j2
@Component
public class LogAdvice {

    //AutoProxy Advice코드 랑 실제(Target)코드랑 같이 결합해서 다 만들어진 것을 프록시라고 부름.
    //          스프링은 자동으로 프록시하기 때문에 AutoProxy
    // 포인트라는 문법. 문자열로 만들다 보니 제대로 적용 되었는 지 알 수 없다...
                // ↓ 포인트 것을 지정하는 aspectj 의 표기법 ReplyService 의 모든 메소드에 이걸 걸겠다.
    @Before("execution(* org.zerock.sp1.service.ReplyService*.*(..))")
    public void printLog(JoinPoint joinPoint){  //만약 여기부터 * 로 하면 service 밑에 있는 모든 것으로 적용 가능
                        //JoinPoint 가 바로 그 메소드

        Object[] params = joinPoint.getArgs(); //메소지를 전달받는 파라미터

        //joinPoint.getSignature() 메소드를 의미
        //joinPoint.getTarget() 실제 내용물

        log.info("----------------------");
        log.info(Arrays.toString(params));
        log.info(Arrays.deepToString(params));
        log.info("----------------------");

        //ProceedingJoinPoint
        //try&catch 는 Exception 보다 상위인 Throwable
        //getArgs() 는 같다.


    }

}
