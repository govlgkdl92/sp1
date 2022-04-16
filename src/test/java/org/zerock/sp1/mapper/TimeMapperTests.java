package org.zerock.sp1.mapper;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/root-context.xml")
public class TimeMapperTests {

                //↓ bean이 있는 지 검사하지 않겠다.
    @Autowired(required = false)
    private TimeMapper timeMapper;

    @Test
    public void testNow(){
        log.info("-------------------------------------");
        log.info(timeMapper.getClass().getName());
                //com.sun.proxy.$Proxy39
        log.info(timeMapper.getTime());
        log.info(timeMapper.getDate());
        log.info("-------------------------------------");


    }


}
