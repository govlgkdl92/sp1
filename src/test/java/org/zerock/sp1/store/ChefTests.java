package org.zerock.sp1.store;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.sp1.sample.SampleDAO;
import org.zerock.sp1.sample.SampleService;

import static junit.framework.TestCase.assertNotNull;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/root-context.xml")
@Log4j2
public class ChefTests {
    @Setter(onMethod_ = { @Autowired })
    //@Qualifier("KoreanChef")
    private Restaurant restaurant;

    @Test
    public void testExist() {
        assertNotNull(restaurant);

        log.info(restaurant);
        log.info("----------------------------------");
        log.info(restaurant.getChef());
    }

}
