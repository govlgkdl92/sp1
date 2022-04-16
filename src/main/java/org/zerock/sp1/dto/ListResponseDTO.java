package org.zerock.sp1.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

//타입은 나중에 정한다. <E>
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ListResponseDTO<E>{
    private List<E> dtoList;
    private int total;

}
