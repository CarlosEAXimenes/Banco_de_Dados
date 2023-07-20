-- criação do banco de dados para o cenário de E-commerce 
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Address varchar(255)
) auto_increment = 1;

drop table clients_pf, clients_pj;

create table clients_pf(
		idClient_PF int auto_increment primary key,
        idClient int,
		Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        constraint unique_cpf_clientPF unique (CPF),
        constraint unique_idClient_clientPF unique (idClient),
        constraint pk_clientPF FOREIGN KEY (idClient) references clients(idClient)
) auto_increment = 1;

create table clients_pj(
		idClient_PJ int auto_increment primary key,
        idClient int,
        CNPJ char(15) not null,
        SocialName varchar(255) not null,
		AbstName varchar(255),
        constraint unique_idClient_clientPJ unique (idClient),
        constraint unique_cnpj_clientPJ unique (CNPJ),
        constraint unique_social_name_client unique (SocialName),
        constraint pk_clientPJ FOREIGN KEY (idClient) references clients(idClient)
) auto_increment = 1;

-- alter table clients auto_increment=1;

-- desc clients;
-- criar tabela produto

-- size = dimensão do produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(255) not null,
        classification_kids bool default false,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);

alter table product auto_increment=1;

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false, 
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
);
alter table orders auto_increment=1;

-- drop table orders;

CREATE TABLE IF NOT EXISTS delivery(
  idDelivery INT AUTO_INCREMENT NOT NULL,
  statusDelivery ENUM("A enviar", "Enviado", "Entregue", "Cancelado") NOT NULL DEFAULT 'A enviar',
  trackingCode VARCHAR(30) NOT NULL,
  deliveryDate DATE NULL,
  idOrderDelivery INT NOT NULL,
  idClientDelivery INT NOT NULL,
  PRIMARY KEY (idDelivery),
  CONSTRAINT unique_tracking_code unique (trackingCode),
  CONSTRAINT fk_delivery_order FOREIGN KEY (idOrderDelivery) REFERENCES orders(idOrder),
  CONSTRAINT fk_delivery_client FOREIGN KEY (idClientDelivery) REFERENCES clients(idClient)
) auto_increment = 1;

-- criando a tabela de cartão de crédito
CREATE TABLE IF NOT EXISTS card (
	idCard INT NOT NULL AUTO_INCREMENT,
	cardType ENUM('Débito', 'Crédito') NOT NULL,
	cardNumber VARCHAR(16) NOT NULL,
	expirationYear CHAR(4) NOT NULL,
	expirationMonth CHAR(2) NOT NULL,
	CVV CHAR(3) NOT NULL,
	idCardClient INT NOT NULL,
	PRIMARY KEY (idCard, idCardClient),
	CONSTRAINT fk_card_payment FOREIGN KEY (idCardClient) REFERENCES clients(idClient)
) auto_increment = 1;

-- criando a tabela para boleto bancário
CREATE TABLE if not exists bankSlip(
	idbankSlip int not null AUTO_INCREMENT primary key,
    expirationDate date not null
) auto_increment = 1;

-- ccriar tabelas de forma de pagamento
CREATE TABLE IF NOT EXISTS payment (
	idPaymment INT NOT NULL AUTO_INCREMENT,
	paymentMethod ENUM("Boleto", "Cartão") NOT NULL,
	idOrder INT NOT NULL,
	idPaymentClient INT NOT NULL,
    idPaymentCard INT,
    idPaymentBankSlip INT,
	PRIMARY KEY (idPaymment, idOrder, idPaymentClient),
	CONSTRAINT fk_payment_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder),
	CONSTRAINT fk_payment_client FOREIGN KEY (idPaymentClient) REFERENCES clients(idClient),
	constraint fk_payment_card foreign key (idPaymentCard) references card(idCard),
    constraint fk_payment_bankSlip foreign key (idPaymentBankSlip) references bankSlip(idbankSlip)
) auto_increment = 1;

show tables;

desc orders;

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;


-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;

desc supplier;

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    location varchar(255),
    contact char(11) not null
);
alter table seller auto_increment=1;

create table seller_pj(
	idSeller_pj int auto_increment,
    idSeller int,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    primary key(idSeller_pj, idSeller),
    constraint fk_sellerPJ_seller FOREIGN KEY (idSeller) references seller(idSeller)
) auto_increment = 1;

create table seller_pf(
	idSeller_pf int AUTO_INCREMENT,
    idSeller int,
    CPF char(9) not null,
    primary key(idSeller_pf, idSeller),
    constraint unique_cpf_seller unique (CPF),
    constraint fk_sellerPF_seller FOREIGN KEY (idSeller) references seller(idSeller)
) auto_increment = 1;

-- tabelas de relacionamentos M:N

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);



desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';