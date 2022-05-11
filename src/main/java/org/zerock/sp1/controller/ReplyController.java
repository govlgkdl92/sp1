package org.zerock.sp1.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.zerock.sp1.dto.ListDTO;
import org.zerock.sp1.dto.ReplyDTO;
import org.zerock.sp1.service.ReplyService;

import java.util.List;
import java.util.Map;

@Log4j2
@RequestMapping("/replies/")
@RestController
@RequiredArgsConstructor
public class ReplyController {
    private final ReplyService replyService;

    @PostMapping("/")
    public Map<String,Integer> register(@RequestBody ReplyDTO replyDTO){
       // log.info("=========================");
       // log.info(replyDTO);

        int totalCount = replyService.register(replyDTO);
        return Map.of("result", totalCount);
    }

    @GetMapping(value = "/list/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ReplyDTO> getListOfBoard(@PathVariable("bno") Integer bno, ListDTO listDTO){

       // log.info("reply list.." + listDTO);

        return replyService.getListOfBoard(bno, listDTO);
    }

    @DeleteMapping("/{rno}")
    public Map<String, String> remove(@PathVariable("rno") Integer rno){

        //log.info("=================================");

        //log.info("remove..." + rno);

        replyService.remove(rno);

        return Map.of("result", "success");
    }



}

   /* @GetMapping("/test")
    public String[] get1(){
        return new String[]{"aaa", "bbb", "ccc"};
    }
              // ↓ 좀 더 엄격한 코딩을 하자만 values,
              // produces : 생산 가능한 미디어 목록을 지정해서 주요 매핑을 제한
              // MediaType.APPLICATION_JSON_VALUE -> json 타입만 만들어 낼 것이다!*/



