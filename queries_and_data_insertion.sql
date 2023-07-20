-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Address
insert into Clients (Address) 
			values('rua silva de prata 29, Carangola - Cidade das flores'),
				  ('rua alemeda 289, Centro - Cidade das flores'),
				  ('avenida alemeda vinha 1009, Centro - Cidade das flores'),
				  ('rua lareijras 861, Centro - Cidade das flores'),
				  ('avenidade koller 19, Centro - Cidade das flores'),
				  ('rua alemeda das flores 28, Centro - Cidade das flores');

INSERT INTO clients (Address)
VALUES
    ('Rua A, Número 123, Bairro X'),
    ('Avenida B, Número 456, Bairro Y'),
    ('Rua C, Número 789, Bairro Z'),
    ('Travessa D, Número 987, Bairro W'),
    ('Rua E, Número 321, Bairro V'),
    ('Avenida F, Número 654, Bairro U');

desc clients_pf;

-- idClient_PF, idClient, Fname, Minit, Lname, CPF
insert into Clients_pf (idClient, Fname, Minit, Lname, CPF)
		values('2','Maria','M','Silva', 12346789),
		     ('3','Matheus','O','Pimentel', 987654321),
			 ('1','Ricardo','F','Silva', 45678913),
			 ('6','Julia','S','França', 789123456),
			 ('4','Roberta','G','Assis', 98745631),
			 ('5','Isabela','M','Cruz', 654789123);

-- Inserindo 6 entradas na tabela clients_pj
INSERT INTO clients_pj (idClient, CNPJ, SocialName, AbstName)
VALUES
    (7, '12345678901234', 'Empresa A', 'Empresa A Abreviada'),
    (8, '98765432109876', 'Empresa B', NULL),
    (9, '56789012345678', 'Empresa C', 'Empresa C Abreviada'),
    (10, '65432109876543', 'Empresa D', NULL),
    (11, '34567890123456', 'Empresa E', 'Empresa E Abreviada'),
    (12, '21098765432109', 'Empresa F', NULL);


select * from clients_pf;

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliação, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0),
                             (5,'Cancelado','compra na loja', 200, 0),
                             (7, 'Cancelado', null, 64, 1),
							 (1, default, null, 55, 0);

-- Inserindo dados na tabela delivery
INSERT INTO delivery (statusDelivery, trackingCode, deliveryDate, idOrderDelivery, idClientDelivery)
VALUES
    ('A enviar', 'ABC123', '2023-07-25', 5, 6),
    ('Enviado', 'XYZ456', '2023-07-26', 6, 2),
    ('Entregue', 'LMN789', '2023-07-27', 7, 3),
    (default, 'JKL321', '2023-07-28', 8, 4),
    ('Cancelado', 'DEF987', NULL, 9, 1);

-- Inserindo dados na tabela card
INSERT INTO card (cardType, cardNumber, expirationYear, expirationMonth, CVV, idCardClient)
VALUES
    ('Débito', '1111222233334444', '2025', '12', '123', 1),
    ('Crédito', '5555666677778888', '2026', '11', '456', 2),
    ('Débito', '9999000011112222', '2025', '08', '789', 3),
    ('Crédito', '4444333322221111', '2024', '09', '321', 4),
    ('Crédito', '8888777766665555', '2023', '10', '654', 5),
    ('Débito', '3333222211110000', '2024', '03', '987', 6);

-- Inserindo dados na tabela bankSlip
INSERT INTO bankSlip (expirationDate)
VALUES
    ('2023-07-25'),
    ('2023-07-26'),
    ('2023-07-27'),
    ('2023-07-28'),
    ('2023-07-29'),
    ('2023-07-30');


-- Inserindo dados na tabela payment
INSERT INTO payment (paymentMethod, idOrder, idPaymentClient, idPaymentCard, idPaymentBankSlip)
VALUES
    ('Boleto', 5, 1, NULL, 1),
    ('Cartão', 6, 2, 2, NULL),
    ('Boleto', 7, 3, NULL, 3),
    ('Cartão', 8, 4, 4, NULL),
    ('Boleto', 9, 5, NULL, 5),
    ('Cartão', 5, 6, 6, NULL);


-- idPOproduct, idPOorder, poQuantity, poStatus

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,5,2,null),
                         (2,6,1,null),
                         (3,7,1,null);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
-- Inserindo 12 entradas na tabela seller
INSERT INTO seller (location, contact)
VALUES
    ('São Paulo', '11999999999'),
    ('Rio de Janeiro', '21999999999'),
    ('Belo Horizonte', '31999999999'),
    ('Porto Alegre', '51999999999'),
    ('Curitiba', '41999999999'),
    ('Salvador', '71999999999'),
    ('Recife', '81999999999'),
    ('Fortaleza', '85999999999'),
    ('Brasília', '61999999999'),
    ('Belém', '91999999999'),
    ('Manaus', '92999999999'),
    ('Florianópolis', '48999999999');

-- Inserindo dados na tabela seller_pj (vendedores pessoa jurídica)
INSERT INTO seller_pj (idSeller, SocialName, AbstName, CNPJ)
VALUES
    (1, 'Empresa A', 'Empresa A Abreviada', '12345678901234'),
    (2, 'Empresa B', NULL, '98765432109876'),
    (4, 'Empresa D', NULL, '65432109876543'),
    (5, 'Empresa E', 'Empresa E Abreviada', '34567890123456'),
    (7, 'Empresa G', NULL, '78901234567890'),
    (9, 'Empresa I', 'Empresa I Abreviada', '23456789012345');

-- Inserindo dados na tabela seller_pf (vendedores pessoa física)
INSERT INTO seller_pf (idSeller, CPF)
VALUES
    (3, '111222333'),
    (6, '444555666'),
    (8, '777888999'),
    (10, '000111222'),
    (11, '333444555'),
    (12, '666777888');


select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);

-- Quantos clientes cadastrados no sistema?
select count(*) from clients;

-- Mostre os códigos dos clientes e seus respectivos pedidos.
select * from clients c, orders o where c.idClient = idOrderClient;

-- Mostre todos os nomes completos dos clientes e respectivos códigos.
select idClient, concat(Fname, ' ', Minit, ' ', Lname) as "Nome Completo" from clients_pf;

-- Mostre todos os Fornecedores ordenados em ordem alfabética por seus Nomes Fantasia.
select SocialName, CNPJ from supplier order by SocialName;

-- Mostre os códigos dos clientes que possuem mais de um pedido e quanto é o total que irão pagar de frete.
select idOrderClient as "Código Clientes", sum(sendValue) as "Frete" from orders group by idOrderClient having count(*)>1;

-- Mostre o nome completo dos clientes com seus respectivos pedidos.
select o.idOrder, o.orderDescription, o.sendValue, o.paymentCash,
       concat(pf.Fname, ' ', pf.Minit, ' ', pf.Lname) AS customerName,
       c.Address AS deliveryAddress
from orders o
join clients c on o.idOrderClient = c.idClient
join clients_pf pf on o.idOrderClient = pf.idClient;




