package org.zerock.sp1.domain;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Board {

    private Integer bno;
    private String title;
    private String content;
    private String writer;
    private Integer replyCount;

    private LocalDateTime regdate;
    private LocalDateTime updatedate;

}
