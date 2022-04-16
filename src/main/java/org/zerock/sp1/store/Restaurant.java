package org.zerock.sp1.store;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Getter
@ToString
@Service
@RequiredArgsConstructor//생성자
public class Restaurant {
//스프링은 하나라도 에러가 있으면 아예 뜨지를 않아요..


    //필드 주입
    @Qualifier("KoreanChef")
    @Autowired//지금부터 chef 타입의 객체를 주입해줘.
    private Chef chef;


    //주입이 필요하면 final 선언
    //생성자 주입 , 자동 주입
    //@Qualifier("KoreanChef")
    //private final Chef chef;

    //autowired 안쓰고 final을 해주고 생성자를 통해서 자동주입하는 방법을 사용한다.
    
/*    public Restaurant(Chef chef) {
        this.chef = chef;
    }*/
}
