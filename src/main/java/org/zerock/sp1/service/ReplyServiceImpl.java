package org.zerock.sp1.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.zerock.sp1.domain.Reply;
import org.zerock.sp1.dto.ListDTO;
import org.zerock.sp1.dto.ReplyDTO;
import org.zerock.sp1.mapper.BoardMapper;
import org.zerock.sp1.mapper.ReplyMapper;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Log4j2
public class ReplyServiceImpl implements ReplyService {

    private final BoardMapper boardMapper;
    private final ReplyMapper replyMapper;
    private final ModelMapper modelMapper;

    //댓글 목록
    @Override
    public List<ReplyDTO> getListOfBoard(Integer bno, ListDTO listDTO) {

        List<Reply> replyList = replyMapper.selectListOfBoard(bno, listDTO);

        List<ReplyDTO> dtoList = replyList.stream()
                .map(reply -> modelMapper.map(reply, ReplyDTO.class))
                .collect(Collectors.toList());

        return dtoList;
    }

    //댓글 추가
    @Override
    public int register(ReplyDTO replyDTO) {
        Reply reply = modelMapper.map(replyDTO, Reply.class);
        //사실은 그대로 넣어도 돼... 하지만 그냥 규칙을 지키자... 마이바티스에서는 엄격히 구분하니까....

        replyMapper.insert(reply);
        boardMapper.updateReplyCount(replyDTO.getBno(), 1);
        //insert 가 안되면 전체 댓글 수 update 가 되면 안되므로 반드시 트랜잭션 처리를 해야 한다!!!!!

        return replyMapper.selectTotalOfBoard(replyDTO.getBno());
    }

    
    //댓글 삭제
    @Override
    public void remove(Integer rno) {

        replyMapper.updateAsRemoved(rno);

    }
}
