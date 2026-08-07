package com.wealthengine.modules.user.controller;


import com.wealthengine.modules.user.dto.UserCreateRequestDTO;
import com.wealthengine.modules.user.dto.UserResponseDTO;
import com.wealthengine.modules.user.service.UserService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

import jakarta.validation.Valid;

import lombok.AllArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/users")
@AllArgsConstructor
@Tag(name = "Users", description = "Endpoints de gerenciamento de usuários")
public class UserController {

    private final UserService userService;

    @PostMapping
    @Operation(summary = "Criar usuário", description = "Cria um usuário e sua conta financeira inicial")
    @ApiResponse(responseCode = "201", description = "Usuário criado com sucesso")
    @ApiResponse(responseCode = "400", description = "Dados inválidos")
    public ResponseEntity<UserResponseDTO> create(@Valid @RequestBody UserCreateRequestDTO dto) {

        UserResponseDTO response = userService.create(dto);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}