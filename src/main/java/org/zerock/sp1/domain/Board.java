package org.zerock.sp1.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.zerock.sp1.dto.UploadResultDTO;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
    private String mainImage;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime regdate;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedate;


}
