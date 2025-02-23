USE jumpStart;
SET NAMES 'utf8mb4';

CREATE TABLE tb_share(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nameShare VARCHAR(255), 
    dateShare DATE,openShare FLOAT, 
    highShare FLOAT, 
    lowShare FLOAT, 
    closeShare FLOAT, 
    volumeShare FLOAT
);

CREATE TABLE tb_news(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    news TEXT, 
    dateNews DATE,
    datePublished DATE, 
    isApproved BOOLEAN
);


CREATE TABLE tb_investor(
   idInvestor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   investorName VARCHAR(255) NOT NULL ,
   investorEmail VARCHAR(255) NOT NULL UNIQUE,
   investorPassword VARCHAR(255) NOT NULL ,
   investorRole VARCHAR(5) NOT NULL CHECK (investorRole IN ('USER', 'ADMIN')),
   operationCode VARCHAR(255) ,
   isAccountValid BOOLEAN NOT NULL
);

CREATE TABLE tb_operationAsset(
 idAsset INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
 assetName VARCHAR(255) NOT NULL ,
 assetType VARCHAR(255) NOT NULL ,
 assetCode VARCHAR(255) NOT NULL,
 assetQuantity DOUBLE NOT NULL CHECK (assetQuantity > 0),
 assetValue DOUBLE NOT NULL CHECK (assetValue > 0),
 operationType VARCHAR(255) NOT NULL CHECK (operationType IN ('BUY', 'SELL')),
 operationDate DATE NOT NULL,
 idInvestor INT NOT NULL,
 isProcessedAlready BOOLEAN
);

CREATE TABLE tb_wallet(
idWallet INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
balance DOUBLE NOT NULL,
idInvestor INT NOT NULL
);

CREATE TABLE tb_walletAsset(
idWalletAsset INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
assetName VARCHAR(255) NOT NULL ,
assetType VARCHAR(255) NOT NULL ,
assetQuantity DOUBLE NOT NULL ,
idWallet INT NOT NULL 
);

CREATE TABLE tb_walletOperation(
idWalletOperation INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
operationType VARCHAR(255) NOT NULL CHECK (operationType IN ('WITHDRAW', 'DEPOSIT')),
operationValue DOUBLE NOT NULL,
operationDate DATE NOT NULL,
idInvestor INT NOT NULL
);

CREATE TABLE list_asset(
    idList INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nameAsset VARCHAR(255) NOT NULL,
    acronymAsset VARCHAR(255) NOT NULL,
    url_image TEXT,
    typeAsset VARCHAR(255) NOT NULL CHECK (typeAsset IN ('CRYPTO', 'COIN','SHARE'))
);

CREATE TABLE tb_crypto(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nameCrypto VARCHAR(255), 
    valueCrypto FLOAT, 
    dateCrypto DATE
);

ALTER TABLE tb_news CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE tb_operationAsset ADD FOREIGN KEY (idInvestor) REFERENCES tb_investor(idInvestor);
ALTER TABLE tb_wallet ADD FOREIGN KEY (idInvestor) REFERENCES tb_investor(idInvestor);
ALTER TABLE tb_walletOperation ADD FOREIGN KEY (idInvestor) REFERENCES tb_investor(idInvestor);
ALTER TABLE tb_walletAsset ADD FOREIGN KEY (idWallet) REFERENCES tb_wallet(idWallet);

CREATE INDEX idx_login ON tb_investor(investorEmail, investorPassword);
CREATE INDEX idx_crypto ON tb_crypto(nameCrypto, dateCrypto, id);

INSERT INTO tb_news (id,news,dateNews,datePublished,isApproved) VALUES
  (1,'{"SHARE": {"description": "Ação da Vale (VALE3) recua e valor de mercado da mineradora bate menor nível desde 2020  Valor Investe", "url": "https://news.google.com/rss/articles/CBMi1wFBVV95cUxNVlczNFluQlBGVTZob2VyV1p2S0ZHUFM0ZDNFbnBxN3BadVk2X295RnFlUzhWUUZLRFFWaVFFUkpFcnNvR0pyUlp4R2VWekJFdmRsenRpMWJ5SGVZZmpMSjVENEpPc3ZnVEJpTmJ1ZGZOLWpIbEp1RndzNFd0ejFVM3I1ck1PSkYtQzJxbXVHNHZ6SG9jMjhTazFKSHZfTEtYbzBtc3BTdjhsc3RQSzhseW9RMkg4NndhWmUteDY0WHlqZDVxenF3SGVwMEdwQkFnX1Q3NlR1UdIB5gFBVV95cUxNWlZwSDJHQnF0ZENibXpJX3k5cWliVUJUaU92ak1uRU5FSHNIdThnYTViaV93NGdaQ0kwWHdxZTF5Mkd4aWdQSC1oOWh0X0V4Y2tyMjZKOG9BNlMteGdiVERuY2ZGUXo1UWd5VVBKRFdFLXE2QzVyRWctdzBXbWNVcWJlMDRJNzhWWktISExzWkpoSkE1Vmo2ZlQ3eFQyX09qM05mY09CSnBYYXdqVGtkNE1NVHM0N1RQVDhTeHJaaTQ5RjduUXZvWU1ycklWUl9FWUZEX1B0eWZCRXM2akI0OWw2bkVOdw?oc=5&hl=en-US&gl=US&ceid=US:en"}}', '2024-12-23','2024-12-19', 1),
  (2,'{"SHARE": {"description": "Onde investir em 2024: confira as melhores ações segundo o BB Investimentos  InvesTalk", "url": "https://news.google.com/rss/articles/CBMigAFBVV95cUxNMDZzQXEySGV4M3RmOTExMGIzb0tuUm5sLVQ4bnIyNnE1V0t6S1NadkRtZm5KOUoxUDlRVE5GN0FZVmo2UnpmdE9QQWZDTEJXdGtYQXUzWWl4bFNLSTlYU1pVUi1FQURqM1NwZ3NvWXo4c3k0UVZXQUtfS2ZmeGEtXw?oc=5&hl=en-US&gl=US&ceid=US:en"}}', '2024-12-23','2024-12-18', 1),
  (3,'{"COIN": {"description": "Dólar hoje: por que real é moeda que mais se desvalorizou e como será em 2025  BBC News Brasil", "url": "https://news.google.com/rss/articles/CBMiYkFVX3lxTE9iRThhVGFFSXh0YTJEZWRRUFlPU0ppSTFQRm1WRU5DMzZkRW5CM093YjVUekozMDNMOS15QW9Pb2FOWDZ0eDkzYTBwTlJqYjU0clFBV0dEcnp2RFBmcWd0a1Z30gFnQVVfeXFMTlJBQkFDNFA3OTI3cEdKTmR5X0daTzhDWlg5aF9pUGZsUTVIWi1XZFhtUDJBLWVQWnp4SHg1cGpwcjNLMUNsMlRNWF92SldTZ2R2TmRSMkJwYjYxMEVaZ0x0RmlUZC1uYw?oc=5&hl=en-US&gl=US&ceid=US:en"}}','2024-12-23','2024-12-18', 1),
  (4,'{"CRYPTO": {"description": "EOS recua 10% em fortes vendas Por Investing.com  Investing.com Brasil", "url": "https://news.google.com/rss/articles/CBMikAFBVV95cUxQZEhXSnRsdXhBV3JiRjhQczlMci02VHNsVDF3ak94U2lKV18zYmN4aGFUam0tVGsyN2VWSlF1WmFYNDBZaWhUMUFwM2FwSExTVjRlZzJySzNYejFIY2pyTm5kQU9MeE1QVFVWQWlRQjhsa2VsX0tOOTRaSnFKUHhnNHFRd0V4T0xCRGNwZHA1WEM?oc=5&hl=en-US&gl=US&ceid=US:en"}}', '2024-12-23','2024-12-22', 1);

INSERT INTO tb_share (id, nameShare, dateShare, openShare, highShare, lowShare, closeShare, volumeShare) VALUES 
(71,	'PETR4.SA',	'2024-10-12',	 37.6,  37.65,	37.32, 37.62,	16343000),
(72,	'BBAS3.SA',	'2024-10-12',	 26.28,	26.46,	26.17, 26.33,	12175400),
(73,	'ITSA4.SA',	'2024-10-12',	 10.52,	10.54,	10.44, 10.47,	11660200),
(75,    'VALE3.SA',	'2024-10-12',	 60.99, 62.27,	60.98, 62.13, 20939400),
(76,	'CMIG4.SA',	'2024-10-12',	 11.12,	11.15,	10.93, 11.02,	12321600),
(77,	'SANB11.SA','2024-10-12',    28.74,	28.85,	28.52, 28.58,	4622300),
(78,	'USIM5.SA', '2024-10-12',    6.27,	6.27,	  6.17,	 6.25,	8909300),
(79,	'ABEV3.SA',	'2024-10-12',	 13.09,	13.12,	12.84, 12.88,	31193700),
(80,	'MGLU3.SA',	'2024-10-12',	 9.22,	9.47,	  8.93,	 9.45,	28500100);

INSERT INTO tb_share (id, nameShare, dateShare, openShare, highShare, lowShare, closeShare, volumeShare) VALUES
(91,    'PETR4.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    37.6,  37.65,  37.32, 37.62,   16343000),
(92,    'BBAS3.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    26.28, 26.46,  26.17, 26.33,   12175400),
(93,    'ITSA4.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    10.52, 10.54,  10.44, 10.47,   11660200),
(95,    'VALE3.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    60.99, 62.27,  60.98, 62.13, 20939400),
(96,    'CMIG4.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    11.12, 11.15,  10.93, 11.02,   12321600),
(97,    'SANB11.SA',	DATE_FORMAT(NOW(), '%Y-%m-%d') ,    28.74,     28.85,  28.52, 28.58,   4622300),
(98,    'USIM5.SA', 	DATE_FORMAT(NOW(), '%Y-%m-%d') ,    6.27,      6.27,     6.17,  6.25,  8909300),
(99,    'ABEV3.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    13.09, 13.12,  12.84, 12.88,   31193700),
(100,   'MGLU3.SA',     DATE_FORMAT(NOW(), '%Y-%m-%d') ,    9.22,  9.47,     8.93,  9.45,  28500100);


INSERT INTO tb_share (id, nameShare, dateShare, openShare, highShare, lowShare, closeShare, volumeShare) VALUES
(101, 'PETR4.SA', '2024-11-14', 38.0, 38.4, 37.8, 38.2, 16500000),
(102, 'PETR4.SA', '2024-11-15', 38.3, 38.6, 38.0, 38.5, 16850000),
(103, 'PETR4.SA', '2024-11-16', 38.5, 39.0, 38.4, 38.8, 17000000),
(104, 'PETR4.SA', '2024-11-17', 39.0, 39.5, 38.9, 39.3, 17500000),
(105, 'PETR4.SA', '2024-11-18', 39.2, 39.6, 39.0, 39.4, 18000000),
(106, 'PETR4.SA', '2024-11-19', 39.5, 39.8, 39.2, 39.7, 18250000),
(107, 'PETR4.SA', '2024-11-20', 39.6, 40.0, 39.3, 39.9, 18500000),
(108, 'PETR4.SA', '2024-11-21', 40.0, 40.5, 39.8, 40.2, 19000000),
(109, 'PETR4.SA', '2024-11-22', 40.2, 40.6, 40.0, 40.5, 19200000),
(110, 'PETR4.SA', '2024-11-23', 40.5, 41.0, 40.3, 40.8, 19500000);


INSERT INTO tb_investor(InvestorName,InvestorEmail,InvestorPassword,InvestorRole,operationCode,isAccountValid) VALUES
("ADM","ADMtotal@gmail.com","OQgewo5JbBLb0XVEobJ9hhDfUqWPENaC","ADMIN","código",TRUE);
-- password adm: 1..8
INSERT INTO tb_investor(InvestorName,InvestorEmail,InvestorPassword,InvestorRole,operationCode,isAccountValid) VALUES
("marcos","marcosemail@gmail.com","yAgKCpfgicZLvdaHtvdFyn2eRNqry/x0","USER","código",FALSE);

INSERT INTO tb_investor(InvestorName,InvestorEmail,InvestorPassword,InvestorRole,operationCode,isAccountValid) VALUES
("admin nome","Email@admin.com","passwordAdmin","ADMIN","código",TRUE);

INSERT INTO tb_operationAsset(idAsset,assetName,assetType,assetCode,assetQuantity,assetValue,operationType,operationDate,idInvestor,isProcessedAlready) VALUES
(1, "BITCOIN","CRYPTOMOEDA","BTC-BRL",0.0003,320.890,"BUY","2024-10-27",1,FALSE);

INSERT INTO tb_operationAsset(idAsset,assetName,assetType,assetCode,assetQuantity,assetValue,operationType,operationDate,idInvestor,isProcessedAlready) VALUES
(2, "BBAS3.SA","AÇÃO","BBAS3.SA",2,14.78,"BUY","2024-10-26",1,FALSE);

INSERT INTO tb_operationAsset(idAsset,assetName,assetType,assetCode,assetQuantity,assetValue,operationType,operationDate,idInvestor,isProcessedAlready) VALUES
(3, "DOLAR","MOEDA","USD-BRL",5,5.40,"BUY","2024-10-26",1,FALSE);

INSERT INTO tb_operationAsset(idAsset,assetName,assetType,assetCode,assetQuantity,assetValue,operationType,operationDate,idInvestor,isProcessedAlready)  VALUES
(4, "ITSA4.SA","AÇÃO","ITSA4.SA",5,18.90,"SELL","2024-10-26",2,TRUE);

INSERT INTO tb_wallet(idWallet,balance,idInvestor) VALUES
(1,1000,1);

INSERT INTO tb_wallet(idWallet,balance,idInvestor) VALUES
(2,2000,2);

INSERT INTO tb_wallet(idWallet,balance,idInvestor) VALUES
(3,5098.87,3);

INSERT INTO tb_walletOperation(idWalletOperation,operationType,operationValue,operationDate,idInvestor) VALUES
(3,"WITHDRAW",5400,"2024-10-26",3);


-- CRYPTO DETAILS --

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Cardano","ADA-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/cardano.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Axie Infinity","AXS-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/axie-infinity.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Bitcoin","BTC-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/bitcoin.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Chiliz","CHZ-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/chiliz.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("EOS","EOS-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/eos.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Ethereum","ETH-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/ethereum.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Chainlink","LINK-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/chainlink.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Litecoin","LTC-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/litecoin.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Tether USDT","USDT-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/tether.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Stellar","XLM-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/stellar.png","CRYPTO");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("XRP","XRP-BRL","https://cdn.investing.com/crypto-logos/20x20/v2/xrp.png","CRYPTO");

-- CRYPTO DETAILS --

-- COINS DETAILS --
INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Boliviano","BOB-BRL","https://paises.ibge.gov.br/img/bandeiras/BO.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Coroa Dinamarquesa","DKK-BRL","https://paises.ibge.gov.br/img/bandeiras/DK.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Coroa Norueguesa","NOK-BRL","https://paises.ibge.gov.br/img/bandeiras/NO.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Coroa Sueca","SEK-BRL","https://paises.ibge.gov.br/img/bandeiras/SE.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Dólar Americano","USD-BRL","https://paises.ibge.gov.br/img/bandeiras/US.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Dólar australiano","AUD-BRL","https://paises.ibge.gov.br/img/bandeiras/AU.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Dólar Canadense","CAD-BRL","https://paises.ibge.gov.br/img/bandeiras/CA.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Dólar Taiuanês","TWD-BRL","https://paises.ibge.gov.br/img/bandeiras/TH.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Euro","EUR-BRL","https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Flag_of_Europe.svg/255px-Flag_of_Europe.svg.png","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Franco Suíço","CHF-BRL","https://paises.ibge.gov.br/img/bandeiras/CH.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Guarani Paraguaio","PYG-BRL","https://paises.ibge.gov.br/img/bandeiras/PY.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Iene Japonês","JPY-BRL","https://paises.ibge.gov.br/img/bandeiras/JP.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Peso Argentino","ARS-BRL","https://paises.ibge.gov.br/img/bandeiras/AR.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Peso Chileno","CLP-BRL","https://paises.ibge.gov.br/img/bandeiras/CL.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Peso Mexicano","MXN-BRL","https://paises.ibge.gov.br/img/bandeiras/MX.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Peso Uruguaio","UYU-BRL","https://paises.ibge.gov.br/img/bandeiras/UY.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Rublo Russo","RUB-BRL","https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Russia.svg/255px-Flag_of_Russia.svg.png","COIN");


INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Libra Esterlina","GBP-BRL","https://paises.ibge.gov.br/img/bandeiras/GB.gif","COIN");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Yuan Chinês","CNY-BRL","https://paises.ibge.gov.br/img/bandeiras/CN.gif","COIN");

-- COINS DETAILS --

-- SHARE DETAILS --

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("AMBEV S/A ON (ABEV3.SA)","ABEV3.SA","https://investidor10.com.br/storage/companies/66b65af53af6c.jpg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Banco do Brasil (BBAS3.SA)","BBAS3.SA","https://investidor10.com.br/storage/companies/66b65b3de91ca.jpg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Cemig (CMIG4.SA)","CMIG4.SA","https://investidor10.com.br/storage/companies/5ea0b6985411c.jpeg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Itaúsa PN (ITSA4.SA)","ITSA4.SA","https://investidor10.com.br/storage/companies/66b65b5f49225.jpg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Magazine Luiza S.A. (MGLU3.SA)","MGLU3.SA","https://investidor10.com.br/storage/companies/5e9deee481287.jpeg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("PETROBRAS PN (PETR4.SA)","PETR4.SA","https://investidor10.com.br/storage/companies/5e98b684e5df2.jpeg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Banco Santander (SANB11.SA)","SANB11.SA","https://investidor10.com.br/storage/companies/66cc9b5c55343.jpg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("USIMINAS PNA (USIM5.SA)","USIM5.SA","https://investidor10.com.br/storage/companies/66cc984b21a8c.jpg","SHARE");

INSERT INTO list_asset(nameAsset,acronymAsset,url_image,typeAsset) VALUES
("Vale S.A (VALE3.SA)","VALE3.SA","https://investidor10.com.br/storage/companies/5ed732a0242b3.jpeg","SHARE");


-- SHARE DETAILS --

INSERT INTO `tb_crypto` (`id`, `nameCrypto`, `valueCrypto`, `dateCrypto`) VALUES
(1, 'ADA-BRL', 6.1134, '2025-01-21');
INSERT INTO `tb_crypto` (`id`, `nameCrypto`, `valueCrypto`, `dateCrypto`) VALUES
(2, 'AXS-BRL', 36.9315, '2025-01-21');
INSERT INTO `tb_crypto` (`id`, `nameCrypto`, `valueCrypto`, `dateCrypto`) VALUES
(3, 'BTC-BRL', 640425, '2025-01-21');
INSERT INTO `tb_crypto` (`id`, `nameCrypto`, `valueCrypto`, `dateCrypto`) VALUES
(4, 'CHZ-BRL', 0.473, '2025-01-21'),
(5, 'EOS-BRL', 4.84085, '2025-01-21'),
(6, 'ETH-BRL', 20088.1, '2025-01-21'),
(7, 'LINK-BRL', 159.249, '2025-01-21'),
(8, 'LTC-BRL', 731.58, '2025-01-21'),
(9, 'USDT-BRL', 6.041, '2025-01-21'),
(10, 'XLM-BRL', 2.7892, '2025-01-21'),
(11, 'XRP-BRL', 19.3801, '2025-01-21'),
(12, 'ADA-BRL', 5.9431, '2025-01-22'),
(13, 'AXS-BRL', 35.8518, '2025-01-22'),
(14, 'BTC-BRL', 625213, '2025-01-22'),
(15, 'CHZ-BRL', 0.46328, '2025-01-22'),
(16, 'EOS-BRL', 4.95, '2025-01-22'),
(17, 'ETH-BRL', 19706.4, '2025-01-22'),
(18, 'LINK-BRL', 153.022, '2025-01-22'),
(19, 'LTC-BRL', 692.7, '2025-01-22'),
(20, 'USDT-BRL', 6.0096, '2025-01-22'),
(21, 'XLM-BRL', 2.657, '2025-01-22'),
(22, 'XRP-BRL', 19.031, '2025-01-22'),
(23, 'ADA-BRL', 5.8018, '2025-01-23'),
(24, 'AXS-BRL', 34.1034, '2025-01-23'),
(25, 'BTC-BRL', 610112, '2025-01-23'),
(26, 'CHZ-BRL', 0.4415, '2025-01-23'),
(27, 'EOS-BRL', 4.66196, '2025-01-23'),
(28, 'ETH-BRL', 19274, '2025-01-23'),
(29, 'LINK-BRL', 148.252, '2025-01-23'),
(30, 'LTC-BRL', 676.12, '2025-01-23'),
(31, 'USDT-BRL', 5.96935, '2025-01-23'),
(32, 'XLM-BRL', 2.5847, '2025-01-23'),
(33, 'XRP-BRL', 18.474, '2025-01-23'),
(34, 'ADA-BRL', 5.898, '2025-01-24'),
(35, 'AXS-BRL', 35.5991, '2025-01-24'),
(36, 'BTC-BRL', 620606, '2025-01-24'),
(37, 'CHZ-BRL', 0.44881, '2025-01-24'),
(38, 'EOS-BRL', 4.71119, '2025-01-24'),
(39, 'ETH-BRL', 20035.4, '2025-01-24'),
(40, 'LINK-BRL', 153.447, '2025-01-24'),
(41, 'LTC-BRL', 706.82, '2025-01-24'),
(42, 'USDT-BRL', 5.9095, '2025-01-24'),
(43, 'XLM-BRL', 2.6132, '2025-01-24'),
(44, 'XRP-BRL', 18.7011, '2025-01-24'),
(45, 'ADA-BRL', 5.7912, '2025-01-25'),
(46, 'AXS-BRL', 33.9359, '2025-01-25'),
(47, 'BTC-BRL', 622060, '2025-01-25'),
(48, 'CHZ-BRL', 0.43413, '2025-01-25'),
(49, 'EOS-BRL', 4.80638, '2025-01-25'),
(50, 'ETH-BRL', 19602.7, '2025-01-25'),
(51, 'LINK-BRL', 147.135, '2025-01-25'),
(52, 'LTC-BRL', 748.27, '2025-01-25'),
(53, 'USDT-BRL', 5.948, '2025-01-25'),
(54, 'XLM-BRL', 2.4602, '2025-01-25'),
(55, 'XRP-BRL', 18.48, '2025-01-25'),
(56, 'ADA-BRL', 5.8514, '2025-01-26'),
(57, 'AXS-BRL', 34.325, '2025-01-26'),
(58, 'BTC-BRL', 620845, '2025-01-26'),
(59, 'CHZ-BRL', 0.44747, '2025-01-26'),
(60, 'EOS-BRL', 4.82847, '2025-01-26'),
(61, 'ETH-BRL', 19568.7, '2025-01-26'),
(62, 'LINK-BRL', 148.856, '2025-01-26'),
(63, 'LTC-BRL', 723.64, '2025-01-26'),
(64, 'USDT-BRL', 5.9207, '2025-01-26'),
(65, 'XLM-BRL', 2.4959, '2025-01-26'),
(66, 'XRP-BRL', 18.4525, '2025-01-26'),
(67, 'ADA-BRL', 5.3759, '2025-01-27'),
(68, 'AXS-BRL', 31.3486, '2025-01-27'),
(69, 'BTC-BRL', 593742, '2025-01-27'),
(70, 'CHZ-BRL', 0.3967, '2025-01-27'),
(71, 'EOS-BRL', 4.3801, '2025-01-27'),
(72, 'ETH-BRL', 18283.3, '2025-01-27'),
(73, 'LINK-BRL', 137.46, '2025-01-27'),
(74, 'LTC-BRL', 654.44, '2025-01-27'),
(75, 'USDT-BRL', 5.936, '2025-01-27'),
(76, 'XLM-BRL', 2.327, '2025-01-27'),
(77, 'XRP-BRL', 16.9301, '2025-01-27'),
(78, 'ADA-BRL', 5.6, '2025-01-28'),
(79, 'AXS-BRL', 31.6851, '2025-01-28'),
(80, 'BTC-BRL', 603000, '2025-01-28'),
(81, 'CHZ-BRL', 0.4036, '2025-01-28'),
(82, 'EOS-BRL', 4.56669, '2025-01-28'),
(83, 'ETH-BRL', 18685.3, '2025-01-28'),
(84, 'LINK-BRL', 139.532, '2025-01-28'),
(85, 'LTC-BRL', 667.69, '2025-01-28'),
(86, 'USDT-BRL', 5.92505, '2025-01-28'),
(87, 'XLM-BRL', 2.4221, '2025-01-28'),
(88, 'XRP-BRL', 18.422, '2025-01-28'),
(89, 'ADA-BRL', 5.4139, '2025-01-29'),
(90, 'AXS-BRL', 29.8804, '2025-01-29'),
(91, 'BTC-BRL', 601000, '2025-01-29'),
(92, 'CHZ-BRL', 0.38051, '2025-01-29'),
(93, 'EOS-BRL', 4.23436, '2025-01-29'),
(94, 'ETH-BRL', 18288.5, '2025-01-29'),
(95, 'LINK-BRL', 133.822, '2025-01-29'),
(96, 'LTC-BRL', 660.06, '2025-01-29'),
(97, 'USDT-BRL', 5.89425, '2025-01-29'),
(98, 'XLM-BRL', 2.34, '2025-01-29'),
(99, 'XRP-BRL', 18.1002, '2025-01-29'),
(100, 'ADA-BRL', 5.6997, '2025-01-30'),
(101, 'AXS-BRL', 31.9449, '2025-01-30'),
(102, 'BTC-BRL', 619238, '2025-01-30'),
(103, 'CHZ-BRL', 0.42767, '2025-01-30'),
(104, 'EOS-BRL', 4.36713, '2025-01-30'),
(105, 'ETH-BRL', 19294.1, '2025-01-30'),
(106, 'LINK-BRL', 146.14, '2025-01-30'),
(107, 'LTC-BRL', 782.39, '2025-01-30'),
(108, 'USDT-BRL', 5.90306, '2025-01-30'),
(109, 'XLM-BRL', 2.3999, '2025-01-30'),
(110, 'XRP-BRL', 18.2995, '2025-01-30'),
(111, 'ADA-BRL', 5.6495, '2025-01-31'),
(112, 'AXS-BRL', 32.4276, '2025-01-31'),
(113, 'BTC-BRL', 610233, '2025-01-31'),
(114, 'CHZ-BRL', 0.42919, '2025-01-31'),
(115, 'EOS-BRL', 4.58541, '2025-01-31'),
(116, 'ETH-BRL', 19592.5, '2025-01-31'),
(117, 'LINK-BRL', 149.152, '2025-01-31'),
(118, 'LTC-BRL', 755.63, '2025-01-31'),
(119, 'USDT-BRL', 5.83238, '2025-01-31'),
(120, 'XLM-BRL', 2.46, '2025-01-31'),
(121, 'XRP-BRL', 18.0699, '2025-01-31'),
(122, 'ADA-BRL', 5.4638, '2025-02-01'),
(123, 'AXS-BRL', 31.2999, '2025-02-01'),
(124, 'BTC-BRL', 600046, '2025-02-01'),
(125, 'CHZ-BRL', 0.4168, '2025-02-01'),
(126, 'EOS-BRL', 4.08, '2025-02-01'),
(127, 'ETH-BRL', 19101.2, '2025-02-01'),
(128, 'LINK-BRL', 144.622, '2025-02-01'),
(129, 'LTC-BRL', 721.07, '2025-02-01'),
(130, 'USDT-BRL', 5.88738, '2025-02-01'),
(131, 'XLM-BRL', 2.4625, '2025-02-01'),
(132, 'XRP-BRL', 17.5596, '2025-02-01'),
(133, 'ADA-BRL', 5.1658, '2025-02-02'),
(134, 'AXS-BRL', 28.299, '2025-02-02'),
(135, 'BTC-BRL', 585761, '2025-02-02'),
(136, 'CHZ-BRL', 0.3825, '2025-02-02'),
(137, 'EOS-BRL', 3.99, '2025-02-02'),
(138, 'ETH-BRL', 18250.4, '2025-02-02'),
(139, 'LINK-BRL', 132.005, '2025-02-02'),
(140, 'LTC-BRL', 688.02, '2025-02-02'),
(141, 'USDT-BRL', 5.8991, '2025-02-02'),
(142, 'XLM-BRL', 2.2563, '2025-02-02'),
(143, 'XRP-BRL', 16.7526, '2025-02-02'),
(144, 'ADA-BRL', 4.0412, '2025-02-03'),
(145, 'AXS-BRL', 23.4312, '2025-02-03'),
(146, 'BTC-BRL', 560506, '2025-02-03'),
(147, 'CHZ-BRL', 0.32388, '2025-02-03'),
(148, 'EOS-BRL', 3.03831, '2025-02-03'),
(149, 'ETH-BRL', 15085.3, '2025-02-03'),
(150, 'LINK-BRL', 108.508, '2025-02-03'),
(151, 'LTC-BRL', 559.42, '2025-02-03'),
(152, 'USDT-BRL', 5.9197, '2025-02-03'),
(153, 'XLM-BRL', 1.8792, '2025-02-03'),
(154, 'XRP-BRL', 13.4129, '2025-02-03'),
(155, 'ADA-BRL', 4.3666, '2025-02-04'),
(156, 'AXS-BRL', 24.5565, '2025-02-04'),
(157, 'BTC-BRL', 574650, '2025-02-04'),
(158, 'CHZ-BRL', 0.3421, '2025-02-04'),
(159, 'EOS-BRL', 3.9893, '2025-02-04'),
(160, 'ETH-BRL', 16207.1, '2025-02-04'),
(161, 'LINK-BRL', 117.599, '2025-02-04'),
(162, 'LTC-BRL', 598.87, '2025-02-04'),
(163, 'USDT-BRL', 5.82459, '2025-02-04'),
(164, 'XLM-BRL', 2.024, '2025-02-04'),
(165, 'XRP-BRL', 15.1549, '2025-02-04'),
(166, 'ADA-BRL', 4.4774, '2025-02-05'),
(167, 'AXS-BRL', 24.7719, '2025-02-05'),
(168, 'BTC-BRL', 573420, '2025-02-05'),
(169, 'CHZ-BRL', 0.34109, '2025-02-05'),
(170, 'EOS-BRL', 3.4251, '2025-02-05'),
(171, 'ETH-BRL', 16354.7, '2025-02-05'),
(172, 'LINK-BRL', 116.151, '2025-02-05'),
(173, 'LTC-BRL', 612.14, '2025-02-05'),
(174, 'USDT-BRL', 5.81845, '2025-02-05'),
(175, 'XLM-BRL', 1.99, '2025-02-05'),
(176, 'XRP-BRL', 14.75, '2025-02-05'),
(177, 'ADA-BRL', 4.3013, '2025-02-06'),
(178, 'AXS-BRL', 23.6239, '2025-02-06'),
(179, 'BTC-BRL', 571806, '2025-02-06'),
(180, 'CHZ-BRL', 0.32735, '2025-02-06'),
(181, 'EOS-BRL', 3.5132, '2025-02-06'),
(182, 'ETH-BRL', 16141.7, '2025-02-06'),
(183, 'LINK-BRL', 113.269, '2025-02-06'),
(184, 'LTC-BRL', 613.56, '2025-02-06'),
(185, 'USDT-BRL', 5.8008, '2025-02-06'),
(186, 'XLM-BRL', 1.9276, '2025-02-06'),
(187, 'XRP-BRL', 13.9799, '2025-02-06'),
(188, 'ADA-BRL', 4.3, '2025-02-07'),
(189, 'AXS-BRL', 24.0576, '2025-02-07'),
(190, 'BTC-BRL', 573269, '2025-02-07'),
(191, 'CHZ-BRL', 0.33493, '2025-02-07'),
(192, 'EOS-BRL', 3.4553, '2025-02-07'),
(193, 'ETH-BRL', 16017.3, '2025-02-07'),
(194, 'LINK-BRL', 113.197, '2025-02-07'),
(195, 'LTC-BRL', 617.89, '2025-02-07'),
(196, 'USDT-BRL', 5.7688, '2025-02-07'),
(197, 'XLM-BRL', 1.9999, '2025-02-07'),
(198, 'XRP-BRL', 14.5663, '2025-02-07'),
(199, 'ADA-BRL', 4.0588, '2025-02-08'),
(200, 'AXS-BRL', 23.594, '2025-02-08'),
(201, 'BTC-BRL', 564500, '2025-02-08'),
(202, 'CHZ-BRL', 0.32829, '2025-02-08'),
(203, 'EOS-BRL', 3.3893, '2025-02-08'),
(204, 'ETH-BRL', 15395.8, '2025-02-08'),
(205, 'LINK-BRL', 106.145, '2025-02-08'),
(206, 'LTC-BRL', 603.32, '2025-02-08'),
(207, 'USDT-BRL', 5.86485, '2025-02-08'),
(208, 'XLM-BRL', 1.9357, '2025-02-08'),
(209, 'XRP-BRL', 14.1444, '2025-02-08'),
(210, 'ADA-BRL', 4.0273, '2025-02-09'),
(211, 'AXS-BRL', 24.51, '2025-02-09'),
(212, 'BTC-BRL', 563482, '2025-02-09'),
(213, 'CHZ-BRL', 0.3433, '2025-02-09'),
(214, 'EOS-BRL', 3.3893, '2025-02-09'),
(215, 'ETH-BRL', 15349, '2025-02-09'),
(216, 'LINK-BRL', 106.792, '2025-02-09'),
(217, 'LTC-BRL', 617.55, '2025-02-09'),
(218, 'USDT-BRL', 5.8559, '2025-02-09'),
(219, 'XLM-BRL', 1.8601, '2025-02-09'),
(220, 'XRP-BRL', 14.1286, '2025-02-09'),
(221, 'ADA-BRL', 4.0866, '2025-02-10'),
(222, 'AXS-BRL', 25.0781, '2025-02-10'),
(223, 'BTC-BRL', 568192, '2025-02-10'),
(224, 'CHZ-BRL', 0.34377, '2025-02-10'),
(225, 'EOS-BRL', 3.74405, '2025-02-10'),
(226, 'ETH-BRL', 15461.4, '2025-02-10'),
(227, 'LINK-BRL', 109.608, '2025-02-10'),
(228, 'LTC-BRL', 681.05, '2025-02-10'),
(229, 'USDT-BRL', 5.7908, '2025-02-10'),
(230, 'XLM-BRL', 1.8636, '2025-02-10'),
(231, 'XRP-BRL', 14.1068, '2025-02-10'),
(232, 'ADA-BRL', 4.6183, '2025-02-11'),
(233, 'AXS-BRL', 24.8418, '2025-02-11'),
(234, 'BTC-BRL', 561246, '2025-02-11'),
(235, 'CHZ-BRL', 0.34382, '2025-02-11'),
(236, 'EOS-BRL', 3.7212, '2025-02-11'),
(237, 'ETH-BRL', 15359.3, '2025-02-11'),
(238, 'LINK-BRL', 110.608, '2025-02-11'),
(239, 'LTC-BRL', 736.35, '2025-02-11'),
(240, 'USDT-BRL', 5.788, '2025-02-11'),
(241, 'XLM-BRL', 1.9684, '2025-02-11'),
(242, 'XRP-BRL', 14.1959, '2025-02-11'),
(243, 'ADA-BRL', 4.4331, '2025-02-12'),
(244, 'AXS-BRL', 24.46, '2025-02-12'),
(245, 'BTC-BRL', 547077, '2025-02-12'),
(246, 'CHZ-BRL', 0.34896, '2025-02-12'),
(247, 'EOS-BRL', 3.6773, '2025-02-12'),
(248, 'ETH-BRL', 14939.7, '2025-02-12'),
(249, 'LINK-BRL', 103.804, '2025-02-12'),
(250, 'LTC-BRL', 657.21, '2025-02-12'),
(251, 'USDT-BRL', 5.76465, '2025-02-12'),
(252, 'XLM-BRL', 1.82, '2025-02-12'),
(253, 'XRP-BRL', 13.7446, '2025-02-12'),
(254, 'ADA-BRL', 4.5085, '2025-02-13'),
(255, 'AXS-BRL', 25.8999, '2025-02-13'),
(256, 'BTC-BRL', 556124, '2025-02-13'),
(257, 'CHZ-BRL', 0.35434, '2025-02-13'),
(258, 'EOS-BRL', 3.7052, '2025-02-13'),
(259, 'ETH-BRL', 15325.4, '2025-02-13'),
(260, 'LINK-BRL', 106.451, '2025-02-13'),
(261, 'LTC-BRL', 694.08, '2025-02-13'),
(262, 'USDT-BRL', 5.81, '2025-02-13'),
(263, 'XLM-BRL', 1.8917, '2025-02-13'),
(264, 'XRP-BRL', 14.1491, '2025-02-13'),
(265, 'ADA-BRL', 4.6244, '2025-02-14'),
(266, 'AXS-BRL', 25.5856, '2025-02-14'),
(267, 'BTC-BRL', 555219, '2025-02-14'),
(268, 'CHZ-BRL', 0.366, '2025-02-14'),
(269, 'EOS-BRL', 3.77725, '2025-02-14'),
(270, 'ETH-BRL', 15488.1, '2025-02-14'),
(271, 'LINK-BRL', 110.257, '2025-02-14'),
(272, 'LTC-BRL', 738.29, '2025-02-14'),
(273, 'USDT-BRL', 5.7333, '2025-02-14'),
(274, 'XLM-BRL', 2.0004, '2025-02-14'),
(275, 'XRP-BRL', 15.66, '2025-02-14'),
(276, 'SOL-BRL', 1132.37, '2025-02-14'),
(277, 'ADA-BRL', 4.5084, '2025-02-15'),
(278, 'AXS-BRL', 25.5867, '2025-02-15'),
(279, 'BTC-BRL', 559564, '2025-02-15'),
(280, 'CHZ-BRL', 0.34493, '2025-02-15'),
(281, 'EOS-BRL', 3.76, '2025-02-15'),
(282, 'ETH-BRL', 15493.6, '2025-02-15'),
(283, 'LINK-BRL', 109.239, '2025-02-15'),
(284, 'LTC-BRL', 754.63, '2025-02-15'),
(285, 'USDT-BRL', 5.73417, '2025-02-15'),
(286, 'XLM-BRL', 2.0176, '2025-02-15'),
(287, 'XRP-BRL', 15.9014, '2025-02-15'),
(288, 'SOL-BRL', 1118.04, '2025-02-15');