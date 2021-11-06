package org.ict.domain;

import lombok.Data;

@Data
public class PayVO {
	String merchant_uid;
	String itemName;
	Long amount;
}
