package org.zerock.sp1.mapper;

import org.zerock.sp1.domain.Reply;

import java.util.List;

public interface ReplyMapper extends GenericMapper<Reply, Integer> {

    List<Reply> selectListOfBoard(Integer bno);

}
