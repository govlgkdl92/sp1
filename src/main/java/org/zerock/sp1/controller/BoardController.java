package org.zerock.sp1.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.sp1.dto.*;
import org.zerock.sp1.service.BoardService;

import java.util.Arrays;
import java.util.List;

@Log4j2 // System.out.print 사용하지 말자. 이것만 사용안해도 성능이 10퍼는 좋아짐
@Controller         //   뒤에 '/'써도 되고 안써도 됨
@RequestMapping("/board/") //get, post 상관이 다 처리하기 위해 사용.. , annotation 기본은 value
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    //상세 페이지지 조회    //@GetMapping({"/read/{bno}", "/modify/{bno}"})   ->이렇게 시도해보기
    @GetMapping("/read/{bno}")
    public String read(@PathVariable("bno") Integer bno, ListDTO listDTO, Model model){
        //log.info("==========bno: "+bno);
        //log.info("======listDTO: "+listDTO);

        model.addAttribute("dto", boardService.getOne(bno));

//      return "/board/read";
        return "/board/read2";
    }


    @GetMapping("/") //공백으로 놔도 됨.
    public String basic(){
        return "redirect:/board/list";
                //send Redirect!
    }

    @GetMapping("/list")
    public void list(ListDTO listDTO, Model model){
                    //@ModelAttribute(name = "cri") 을 사용하면 이름 설정 가능
                    // DTO 는 아무것도 안해도 전달된다!

                    //@RequestParam(name="page", defaultValue = "1", required = true) int page
                    //별로 좋지 않은 함수.. -100page 등 잘못된 수를 막지 못한다.. 그래서 dto로 설계하는 게 나음
        //log.info("board list.........");
                    // log.info("page : "+page);

        //log.info(listDTO);
        ListResponseDTO<BoardDTO> responseDTO  = boardService.getList(listDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getTotal();

        model.addAttribute("pageMaker", new PageMaker(listDTO.getPage(), total));
    }

    @GetMapping("/register")
    public void registerGET(){

    }


    @PostMapping("/register")
    public String registerPOST(BoardDTO boardDTO, RedirectAttributes rttr){
        log.info("등록 시....post................");
        log.info(boardDTO);

        /* 중요 !!!! */
        // rttr.addAllAttributes()  -> 계속 똑같이 문자열 만들어냄
        // rttr.addAttribute("num",321);
        boardService.register(boardDTO);
        rttr.addFlashAttribute("result", 123);

        return "redirect:/board/list";
    }

    //삭제 오류 메시지 -> 리스트로 보내기
    @GetMapping({"/remove/{bno}"})
    public String getNotSupported(){
        return "redirect:/board/list";
    }


    //수정 페이지에서 삭제
    @PostMapping("/remove")
    public String removePost(@PathVariable("bno") Integer bno, RedirectAttributes rttr){

        //log.info("--------------------remove: " + bno);
        //log.info("--------------------------------------");

        boardService.remove(bno);
        rttr.addFlashAttribute("result", "removed");
        return "redirect:/board/list";
    }


/*    //수정 페이지
    @GetMapping( "/modify/{bno}")
    public String modify(@PathVariable("bno") Integer bno, ListDTO listDTO, Model model){
        //log.info("==========bno: "+bno);
        //log.info("======listDTO: "+listDTO);

        model.addAttribute("dto", boardService.getOne(bno));

        return "/board/modify";
    }*/
    
    //수정 페이지에서 수정
    @PostMapping("/modify/{bno}")
    public String removePost(@PathVariable("bno") Integer bno, BoardDTO boardDTO, ListDTO listDTO, RedirectAttributes rttr ){
       //log.info("--------------------modify: " + boardDTO);
       //log.info("---------------------수정!!-----------------");

        boardDTO.setBno(bno);
        boardService.update(boardDTO);

        rttr.addFlashAttribute("result", "modified");

        return "redirect:/board/read/"+bno+ listDTO.getLink();
    }


    //상세 조회 페이지의 전체 이미지 조회 (더보기)
    @GetMapping("/files/{bno}")
    @ResponseBody
    public List<UploadResultDTO> getFiles(@PathVariable("bno") Integer bno){

        return boardService.getFiles(bno);
    }
}
