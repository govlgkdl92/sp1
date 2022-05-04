package org.zerock.sp1.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
    private Integer bno;
    private String title;
    private String content;
    private String writer;
    private Integer replyCount;

    private LocalDateTime regdate;
    private LocalDateTime updatedate;

    private List<UploadResultDTO> uploads = new ArrayList<>();
}
