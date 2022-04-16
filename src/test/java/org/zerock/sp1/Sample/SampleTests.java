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

}
