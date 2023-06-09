package ru.practicum.ewm.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.practicum.ewm.dto.user.UserShortDto;
import ru.practicum.ewm.model.ReactionStatus;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReactionOnEventDto {
    private Long eventId;
    private UserShortDto participant;
    private ReactionStatus reaction;
}