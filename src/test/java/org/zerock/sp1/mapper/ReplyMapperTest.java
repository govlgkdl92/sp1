package org.zerock.sp1.mapper;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.sp1.dto.ListDTO;

//Spring으로 테스트 하기 위한 세 줄
@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/root-context.xml")
public class ReplyMapperTest {

    @Autowired(required = false)
    private ReplyMapper mapper;

    @Test
    public void testList1(){
        Integer bno = 32755;

        ListDTO listDTO = new ListDTO();
        listDTO.setPage(2);
        listDTO.setSize(10);

        mapper.selectListOfBoard(bno, listDTO).forEach(reply -> log.info(reply));
    }


}
