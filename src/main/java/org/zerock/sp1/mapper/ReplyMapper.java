package org.zerock.sp1.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.sp1.domain.Reply;
import org.zerock.sp1.dto.ListDTO;

import java.util.List;

public interface ReplyMapper extends GenericMapper<Reply, Integer> {
    List<Reply> selectListOfBoard(@Param("bno") Integer bno, @Param("listDTO")ListDTO listDTO);

    int selectTotalOfBoard(Integer bno);
}
