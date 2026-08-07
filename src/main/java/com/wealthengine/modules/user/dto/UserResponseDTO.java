package com.wealthengine.modules.user.dto;

import com.wealthengine.modules.user.entity.UserEntity;

import java.time.OffsetDateTime;

public record UserResponseDTO(
        Long id,
        String name,
        String email,
        OffsetDateTime createdAt
) {

    public UserResponseDTO(UserEntity user) {
        this(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getCreatedAt()
        );
    }
}