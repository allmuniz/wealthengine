package com.wealthengine.modules.account.service;

import com.wealthengine.modules.account.entity.Account;
import com.wealthengine.modules.account.repository.AccountRepository;
import com.wealthengine.modules.user.entity.UserEntity;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;


    public Account create(UserEntity user) {
        Account account = new Account(user);
        return accountRepository.save(account);
    }
}