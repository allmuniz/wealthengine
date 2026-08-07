package com.wealthengine.modules.account.repository;

import com.wealthengine.modules.account.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepository extends JpaRepository<Account, Long> {
}
