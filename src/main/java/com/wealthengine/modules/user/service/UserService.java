package com.wealthengine.modules.user.service;

import com.wealthengine.modules.account.service.AccountService;
import com.wealthengine.modules.user.dto.UserCreateRequestDTO;
import com.wealthengine.modules.user.dto.UserResponseDTO;
import com.wealthengine.modules.user.entity.UserEntity;
import com.wealthengine.modules.user.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AccountService accountService;

    @Transactional
    public UserResponseDTO create(UserCreateRequestDTO dto) {

        String encodedPassword = passwordEncoder.encode(dto.password());
        UserEntity user = new UserEntity(dto, encodedPassword);

        userRepository.save(user);
        accountService.create(user);

        return new UserResponseDTO(user);
    }
}