package org.zerock.sp1.service;

import org.springframework.transaction.annotation.Transactional;
import org.zerock.sp1.dto.BoardDTO;
import org.zerock.sp1.dto.ListDTO;
import org.zerock.sp1.dto.ListResponseDTO;
import org.zerock.sp1.dto.UploadResultDTO;

import java.util.List;

@Transactional
// 어떤 xml에 component-scan을 설정해야 하나... servlet은 servlet과 관련된 api를 사용하고 있는 지 파악...
public interface BoardService {

    void register(BoardDTO boardDTO);// 등록

    ListResponseDTO<BoardDTO> getList(ListDTO listDTO);

    BoardDTO getOne(Integer bno);

    void update(BoardDTO boardDTO);

    void remove(Integer bno);//삭제

    List<UploadResultDTO> getFiles(Integer bno); //여러 이미지 가져오기 (상세 조회시)

}
