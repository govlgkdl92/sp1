package org.zerock.sp1.service;

import org.zerock.sp1.dto.BoardDTO;
import org.zerock.sp1.dto.ListDTO;
import org.zerock.sp1.dto.ListResponseDTO;

// 어떤 xml에 component-scan을 설정해야 하나... servlet은 servlet과 관련된 api를 사용하고 있는 지 파악...
public interface BoardService {

    //DTO generic을 이용해서 뺄 수 있다...

    ListResponseDTO<BoardDTO> getList(ListDTO listDTO);

    BoardDTO getOne(Integer bno);

    void update(BoardDTO boardDTO);

    void remove(Integer bno); //삭제
}
