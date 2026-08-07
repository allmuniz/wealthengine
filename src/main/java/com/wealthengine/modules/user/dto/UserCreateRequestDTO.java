package com.wealthengine.modules.user.dto;

public record UserCreateRequestDTO(
        String name,
        String email,
        String password
) {
}
