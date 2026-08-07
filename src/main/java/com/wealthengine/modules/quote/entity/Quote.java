package com.wealthengine.modules.quote.entity;

import com.wealthengine.modules.asset.entity.Asset;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "tb_quotes")
public class Quote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "asset_id", nullable = false)
    private Asset asset;

    @Column(name = "trading_date", nullable = false)
    private LocalDate tradingDate;

    @Column(name = "opening_price", nullable = false, precision = 19, scale = 4)
    private BigDecimal openingPrice;

    @Column(name = "closing_price", nullable =false, precision = 19, scale = 4)
    private BigDecimal closingPrice;

    @Column(name = "minimum_price", nullable = false, precision = 19, scale = 4)
    private BigDecimal minimumPrice;

    @Column(name = "maximum_price", nullable = false, precision = 19, scale = 4)
    private BigDecimal maximumPrice;

    @Column(name = "average_price", precision = 19, scale = 4)
    private BigDecimal averagePrice;

    @Column(name = "traded_quantity")
    private Long tradedQuantity;

    @Column(name = "traded_volume", precision = 19, scale = 2)
    private BigDecimal tradedVolume;

    @Column(name = "number_of_trades")
    private Long numberOfTrades;

    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @PrePersist
    public void prePersist() {
        createdAt = OffsetDateTime.now();
    }

}