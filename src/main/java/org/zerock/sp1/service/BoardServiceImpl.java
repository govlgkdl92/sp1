package org.zerock.sp1.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.zerock.sp1.domain.Board;
import org.zerock.sp1.dto.BoardDTO;
import org.zerock.sp1.dto.ListDTO;
import org.zerock.sp1.dto.ListResponseDTO;
import org.zerock.sp1.mapper.BoardMapper;

import java.util.List;
import java.util.stream.Collectors;
//controller, repository, service 3가지 기억하기

@Service
@RequiredArgsConstructor
@Log4j2
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;
    private final ModelMapper modelMapper;

    //리스트
    @Override
    public ListResponseDTO<BoardDTO> getList(ListDTO listDTO) {
        List<Board> boardList = boardMapper.selectList(listDTO);

        List<BoardDTO> dtoList =
                boardList.stream()
                        .map(board -> modelMapper.map(board, BoardDTO.class))
                        .collect(Collectors.toList());
        return ListResponseDTO.<BoardDTO>builder()
                .dtoList(dtoList)
                .total(boardMapper.getTotal(listDTO))
                .build();
    }


    //조회 - bno로 한 값만 가져오기
    @Override
    public BoardDTO getOne(Integer bno) {
        Board board = boardMapper.selectOne(bno);
        BoardDTO boardDTO = modelMapper.map(board, BoardDTO.class);

        return boardDTO;
    }


    //조회에서 수정
    @Override
    public void update(BoardDTO boardDTO) {
        Board board = Board.builder()
                            .bno(boardDTO.getBno())
                            .title(boardDTO.getTitle())
                            .content(boardDTO.getContent())
                    .build();
        boardMapper.update(board);
    }


    //삭제
    @Override
    public void remove(Integer bno) {
        boardMapper.delete(bno);
    }
}
