package org.zerock.sp1.Sample;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.sp1.sample.SampleDAO;
import org.zerock.sp1.sample.SampleService;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/root-context.xml")
public class SampleTests {

    @Autowired
    private SampleDAO sampleDAO;

    @Autowired
    private SampleService sampleService;

    @Test
    public void test1(){
        log.info(sampleService);
    }


    @Test
    public void testLink(){
        String mainImage;

        mainImage = "/view?fileName=2022/05/06/s_8e502d39-c4ae-4afd-9e49-fc2c174c0974_공기살인.jpg";
        // split은 쉬울 거 같긴 한데 중간에 s_가 들어가는 이름이 있으면 문제가 된다.

        int idx = mainImage.indexOf("s_");
        String first = mainImage.substring(0, mainImage.indexOf("s_")); /* 필요한 S_ 가 처음 나올 수 밖에 없으므로 substring으로 처리 */
        String second = mainImage.substring(idx+2);

        log.info(first+second);
    }
}
