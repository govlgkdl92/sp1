package org.zerock.sp1.service;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/root-context.xml")
public class TimeServiceTests {

    @Autowired
    private TimeService timeService;

    //@Transactional
    @Test
    public void testInsertAll(){



        log.info("----------------------------");
        log.info(timeService.toString());
        //com.sun.proxy.$Proxy54
        //AOP가 제대로 걸려있다면 이 주소가 나올 것이다!

        String str = "아름다운 이땅에 금수강산에 단군 할아버지가 터 잡으시고 " +
                "홍익인간 뜻으로 나라 세우니 대대손손 훌륭한 인물도 많아 " +
                "고구려 세운 동명왕 백제 온조왕 알에서 나온 혁거세 " +
                "만주벌판 달려라 광개토대왕 신라장군 이사부";
        timeService.insertAll(str);

        String title = "한국을 빛낸 백명의 위인";
        //timeService.insertAll(title);

    }

}
