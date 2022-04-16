package org.zerock.sp1.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BoardDTO {
    private Integer bno;
    private String title;
    private String content;
    private String writer;

    private LocalDateTime regdate;
    private LocalDateTime updatedate;
}
