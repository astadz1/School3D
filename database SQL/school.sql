-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 28 déc. 2023 à 12:12
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `school`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DropAllTriggers` ()   BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE trigger_name VARCHAR(255);

    -- Cursor to fetch all triggers
    DECLARE cur_triggers CURSOR FOR
        SELECT trigger_name
        FROM information_schema.triggers
        WHERE trigger_schema = DATABASE();

    -- Handler for no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Loop to drop triggers
    OPEN cur_triggers;
    read_loop: LOOP
        FETCH cur_triggers INTO trigger_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET @stmt = CONCAT('DROP TRIGGER IF EXISTS ', trigger_name);
        PREPARE stmt FROM @stmt;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;
    CLOSE cur_triggers;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `pdfFile` varchar(255) DEFAULT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `courses`
--

INSERT INTO `courses` (`course_id`, `title`, `description`, `pdfFile`, `category`) VALUES
(1, 'fsafa', 'fsafas', 'mémoire.pdf', 'Math'),
(2, 'fsafa', 'fsafas', 'mémoire.pdf', 'Arab');

-- --------------------------------------------------------

--
-- Structure de la table `eleve`
--

CREATE TABLE `eleve` (
  `id` int(11) NOT NULL,
  `classe` varchar(20) DEFAULT NULL,
  `year` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `eleve`
--

INSERT INTO `eleve` (`id`, `classe`, `year`) VALUES
(271, NULL, NULL),
(272, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `enfant_parent`
--

CREATE TABLE `enfant_parent` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `eleve_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enfant_parent`
--

INSERT INTO `enfant_parent` (`id`, `parent_id`, `eleve_id`) VALUES
(1, 270, 271),
(2, 270, 272);

-- --------------------------------------------------------

--
-- Structure de la table `parent`
--

CREATE TABLE `parent` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `parent`
--

INSERT INTO `parent` (`id`) VALUES
(270);

-- --------------------------------------------------------

--
-- Structure de la table `prof_principale`
--

CREATE TABLE `prof_principale` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `prof_simple`
--

CREATE TABLE `prof_simple` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `birthDate` date NOT NULL,
  `birthPlace` varchar(30) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(120) NOT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `userType` varchar(30) NOT NULL,
  `PhotoProfil` blob DEFAULT NULL,
  `salt` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `firstName`, `lastName`, `birthDate`, `birthPlace`, `email`, `password`, `PhoneNumber`, `userType`, `PhotoProfil`, `salt`) VALUES
(58, 'Bedjaoui', 'Salah Eddine', '2002-06-19', 'Sidi Bel Abbes', 'sohaib0@gmail.com', '$2y$10$2Dzg3id1tSygFB/E2uA/tuUXD2d5LaN5jXbNxuwDkgyEOot8iNy0y', '0557743163', 'Admin', 0xffd8ffe000104a46494600010100000100010000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc20011080190019003012200021101031101ffc4001c0001000301010101010000000000000000000102030405060708ffc4001a010101010101010100000000000000000000010203040506ffda000c03010002100310000001fe551400000000000000000000000000000000000000042250d25120098589085e0aca488bc15008cd940942250251340000000000000010289016266c91330445656511179ce0d673b11169b335a162252c08084c4814000000000000041209d45a2c894c5688b66ceb8eef7ff5cf43c5f47f9a7cdfe90fc9baf0f889476f36acf4d444d6ca8544c4a1098980a0000000000000224a5a2d64ca64998b1cd3136cfea7f95ff4071eff00a1f37567e2fa9e4fc2fda7e27d38f8ff003bf6bf3deaf9be5e99cef3ad346b39d6f5a84c4b098cd4c4c0500000000000000275178ba4cca1689396626d7eedf88fecde7f578de9799fa0f2efb7e69fa978b3b717cefea5f0e7e151be1ebf93b4d74d4a2094898d544c66a6260000000000000001a534d662e989b56c49539a6b36fa7fd11fcd3fb5f9bdff00a96be3efc3dde0785f77f38cf0793f3ff5b71f88717ade4fafe4df6e7e8de62b6aa569a52d818b131205000000000000013a677b340936a684e3b735b99195be87e7acd7f43fbdf90feabe0fb1f27f23fb364e9f977a1f5bf95f4f2fc4f31eaf98d72d2cbc5ab6452f4b602c4c4e400000000000000b591649a4e5a24dea2fc9b73aa259a9adaafeff00cf49fae7aff86578fa7f44f82e78df20d734c0e88cf4d48cef5b2a1624942000000000000012f689b22f51a2b6232eae8cf7f3a7dfe5e7edf1651d7e6ccd5a5aa4819b001244f6699efc48af4f38504a10000000000000989b2e4a4da9729df7f4b97d6e3d7b5c7eaf35ef55f1387eabcde9f27c65abd7e585088017a7ab9edd5a5a9c3ef72797f43e6efc1e711dfe52624000000000000002ad35bd9335edcf4f5b5adbcbfa9b456d3adaa931d2d95e7c7e77b7a6bc3f2f4fa6e4df87c47ad378f8fa7afd13b7176da397d09c76e76ba397a313cce5f5bcbeff0012b313af38500000000000000986a6deff0099ea79fecdaf95f97d4bc44b73306a4aa5b1b4a611be6e74bf3c3975636bddd62d1335ced5bca6b5ab38e36cba7cfe5989ebf3c28000000000000013a9ebf6736fe4fd1693567d575686f18553a32c8c5e6b634be274db2a99cf5ce18e8ae6b59e94bcb130d79ab34d6f1f396af5f9a16000000000000009857b9a67af97f4714d699eb5c3a297972e96e8d729d22f8f54a0d4e77cd295bc5c52cb2426088a1ca39f7c77e6c75e7def3e5c7ab977e10df200000000000002262c7b7a73cf9bf41d8e399d75cf2ade73d5c3dd7179a5b3e9b4444a845c296cd8b4d2535a2ab94446f84e5395e19ed86ae33cbd5cfac663a79000000000000008eae5edc76ebd739e5f6af06759e3af3ebcd5ede4e9b369c2d3d1b322deb1108986131535a3333576d70c79b7e6d7974bd6f3518eb95e798ebe4000000000000023ab97ab1dbb672bf2fafa573988e4e9e7df8f6eaf3365ed8e6b3b6d3cf9a76c715e4e963a3a4c77fab27ced3d8f3ee38dd9db787cee9f51f217974657a3719cd37e70d72000000000000023a79ba31dba6d473fa7ae9cfab77caf8b3e70edf1400058eefa9f3bb79fafe8fb3e53d5e7dfabe33ec3cb67e676c33e9e6ecf077c2e2d11174acc6b9058000000000000046d8db3aed8ce797d0da71b3a6b9db2b38c75f94000ebe4b4bee7a9e5e98f477757370cdfd8f8fc3ce9c5e676d77c78275cd2215b1313701400000000000004085aa2faf3a6fb6bcd7cf7c86fca00005ba7912f67abf3c6bb35e0ec33ce2b16a4c5553170989028000000000000081000000000000004e990b5a969b44d49a97098902800000000000008100000000000000009816a800989028000000000000084a212212212212212212212212212212212212212224a00000000000000000000000000000000000000000000000003ffc4002f100001030302050304020203000000000001000203041011051213202131402230500614324215412333347080ffda0008010100010502ff00a9b0b1f219595959f8ac5cf3e7e1f173d2fd95169afa963be9c71655504d486e2e7e04721bd2d39abaaa3d2db4b07da8c55d1b5eb57d0f807973f00393fabfd11a78926c0c152c591a9cb0d30d4e0bb6d8f84feaff0049c3f6da547ea123999d46ab830b2a1914d51a8beb4d751ba95f608fc314064c26a16a52cb1c9a44e617d7c1f79494ba6c75029b4a8a16eb544d7c27ba69f88a56eea8ab8ea78343f4bccd969f4c6c2c0763aba97ecaa4063e3d5c6d137fb933e17b5f4dc7dfd210e2c8daf4f608639e5e13b57af9eba0a39b830eab97b2b1bb2a137ba3e68e67764146fd8fd235113c54d53855327154a18e55d5b410364d7639249c0fe3f54ff976cf9c39a43c9a457fdacf11796309d9aa7f2556d1a04c043a3705d572f0a3a8938b359be703c82cfefc9f4f6bfc151ced2896bd1a5e22aa68806bd55e9bb7e0f28f7be6d43ad54512a5fa9617877d40c60aefa8b2679dd3bee3cc1c82ee3d3df06e7c917ce2e4656d29ac2e323361f7cf962d9b009ac09a40154ddccf7208f727c0bb7982ec8461b0ae0a0dc2daaa20d87da6b7718dbb5aa68939b8f369e2ca0d4058841c9ccca920051183ec53c5778c891996f963a960c37908caeac590f52d2ef4ea67351691cad617a8a9f6a6f4457eddd3c61d33307caa78f2e1ce58b716ac829d1028d3357da357d984299ad41a1ab36ee1e9aa5ea31bdae1b4f90c1bcb46d1ec98d7adab72ca05632b6e0f4bbba861cb653e967699be4d3b4fb59bb980a2c216e2107e57758445dbd0cbf8876138e7c9a7ff005f26565616d5b0af585c4210782b362d5b76a1626e7f22729bdde3c988623cdb36270b72326171495bcacb97a975585945c56e2ba840a3628852746b5393860f8ec3962ce1755bc845c4a298dca0c5b794dc58acde5190dec9fe433f158b1167f660e5cfb39b3936ceede38ec859d67143da17cf5ca25143be51ea8f8c3bee5bcac95b8a24adeb3ebb67d80b363f9656538a17778d13535bc8515fb02b36cdc959b8bfec8a72177f8d11c816cd9c9e537adb36cacfb3fb2723dc0bbbc68793289ca77e40e08f77f6712b3940351b651f1a2b65656dcae1a746e6a1261719715ab88d4650171971d71c2e20287a94744e299a78535298896211b5ca064829e5d3e29a8134afefc78fa345c5a53e9f629590bcc0d644a2a60032aa2dd54ce3095858ece1715cd02bb0c417f67c78ee165654df8f381934140dccf57140f8cd45696b194a84c1eaa636b93d9c321f83507fc9e547def9b4bf8f3d3bb6be4a97cc696899134d5081d1b5d31d564a4a72c797b6ae404b9f9f301c2dcb2b3793f1e71de3a863631c6a810322a50ea973ded8042aa6b0cee7461ab86dc3d9b7cdcadc83acff00c7d8ca6ce581b3f5fe4b609aa5f3963486bddd77908b89f800708bf23dc1dcbca3f23bbff3bfffc4002a11000202010204060203010000000000000001021103122104103031132022404151324214607161ffda0008010301013f01fea71c0ab7326171dd7b7c2ae45996743fbf6d8be4c6a576c942fb9282d3edb86a7b1a47b8ded43efed632d2ed11c9ad0a546575bfb74dc7b0b88912c8e7dfda63c52993e174c2fe7ceb0c9c752f61c370da96a911c31469a33f095ea8797163f125425a76389c3fb2eb6386b924887a557369a27c363c9ff09f0725d8fe2e423c1bfd88e38c16c327bc4cb0d2efabc263d2b508be6d2638d762ebb9b318c6fd04e9c6bab876825cac7346a47f85b1bfb2fe8b1927a5312b88fa98ff0015c9a628fa848be4c431993b10771322a7d4849246b25346376cb2c6c6cb1b2c9b21d8ccb6be9e149cb723b164d98b62cd45f36f964644c8f6e9e2fcd0997f465d55d88668a3c58bf91e582f93c687d8a499a8f10964fa1486ef7449df4f17e4589995fa1f961e95b964b922c7d38ba76298a4647e87e44e99fe97f65d21ee21beb29b478a9c69f95368d6c4cb7ee50ffab7ffc40023110001030305000301000000000000000001000211102030031221314013416071ffda0008010201013f01fc99d5329ba9bbbf3ea986aed35a879b53b4e8fa4de10773e6d51f6a50508790a2242734b4d07341e58057c410681e4250772850d9bb9433b9d50eb498a34e6262d0e216f5b82dc899a040e5799c8329ef28c872b739c25371bbaa84542851514146e3350a14282a0d245a319eaa2d2542160cc2dfe523c30a2e8fd97fffc400361000010302030506030705000000000000010002110321123150102022305104133240416152627105142360808191425370a1c1ffda0008010100063f02fd1e628b2b58ae3618eba7d2a2dcdee84da6065b20890b1d0b8f56e9d53b53878385bb9f88f8e83d577cda4ea60f51a6d39cdfc6aebdd1c39c27769ed2eefaafa4de10a66978affb2f94e5a5809943b3616329b4627b91655fb51cff00918216297d40444b8a3873841954196fa2e06009c34ba43e608b3b359cef54dad56b45407170dcab36e4c977a94026d7c9a7c4a5a6514ffae9543a62086c24a2e333fd23aa653c241ff89ace8a7d13c694d70cc19408d802122611ef2ab0380ca6eb051a4fb9b12af9a76961a7c2e3fc20e6dd62e8b0d28a4c39c3ae571b4e2faa0e3777b233927bba9d30767ae61be8e2b84820ee611993a7610ec54fe12b89d84f42ad502761e22b13bfc197bab052331cd956d02eb2dc91969988ee5b6e507952773dc79c840722467b2fbb657de9f378bd0722cafb99acf4301472a458aeab3e64f999e75b911a266b35d55dbcb07ce0e4586e5f732d086a43cc1fc9b96a13f990ef0d30ef4ee66b3d996ccd5aeae6178717b951b21546f161c5329f59afc15a9dfbb8cc682793f8ae214536fee54bbfdac2de28e8a611d934ec5383d9188470e930b154cd5b89dd02e37776ce833585a21668c2becb693eeb052fe517bce2a8ba9e8162aaec0df80267dceae3a3026d0415310dea74cbab370afed8539bbe22a180bbe883eb9bfc0b0b3259c9d36ca5dc5f55c0d852ed53dff551ffc400291000020202010402020203010100000000000111211031412040516130718191a1c160b1f0d1e1ffda0008010100013f21ff00289249249ec649249249249ed5fc9183810294448d47c8bb47f0a46913196243a1a486a3e25da3eb420dba1a32e3a131328fb206afe15da3e94a450c2525199810bbb670a8dede721ea7055594e069f8cbb47f01558d2f0b42e06d0a95f148398845019c32590f6f83e869a7ef09c33de1cbe05da3e84cd782324e891c4bf3724532fc0e73689929dfb5be913be46549fbcb70460d75aed1f42163472e8a32f6df9ffe2437a82146bd06369b9a92430b6d7f8035ca71a391216bfd6c270cb2106ac66ba5770848e447d9ce1eec704f89469a7e1239298e03ea98b2d1f662d915a306923e2894546f643fd83d8842bdaa1219738a06a5f4bcaeda0485bc2c450f6c5e0f66abf920e2e5aa3d8fb0ae541afb4325933eff006c8e79a81d15295bc4ec8c446a65081ac23df0d0c66b0d74aed928c25421086e0f0988d3f287c38706b90ec648b5ca841b09049b6954ac6a57a723458fb527a049c7179785db92c2c4be0df931c3483d6deca163e3ba6c528be0a12aee4acbeb02469080a46ad4d9a7f5432abc2c2a629243d0f0f78785daa2fd1122507074399fccf21fac3d0d27e4394e7495fd0f5b8aa3449a5e9522c8881ee57365d0fa176d67c2561319e4dfc316cf808809d931468645526c9d01e19bef52f3982707961eb2a1883fe04fd095f4cff78ec54ccbfa19df2df1e3a1a188787be85da340af130698445f6c71947d324689f7d71676cb176c89445e09911046ae08940d8d8f3304e63a93813ee88b2c351732293158c7a52439fc06a80b57c00df4ca6ca8aa5069efd2bb45be86c8730884729f448a992122471c725636165fe372522386a4544a18e4f79e9dc095f5e0415a23b1c0c52563d31c9efe181790e04e194a4928b3a176a99a108d49cb238e04ec98e8f2cbb434bc8b6923d8f7631a474ba84936aef21b1a165c32ada795daa7027387a9828493399367d66703425699c1c7d0e3bd0e4d8f7c6de7ecf004781b9242b0fc0d424c8840f91b03e30bb76f94128450b09d653270f66c537fa027628792da5fca27a70df04ca2206c96c6965fd89a691364c0b291922243e84ae185dbadaef42708d90893943844af26893624df26c51be4a1397c6ce08d083d9b0687e18f28dde8fb2377c2edde52787844e106af645f2327c23ea1c83ed1e9307689af4c734f037e87a9281f91f91e1015bb154913aa1f22ed909faa5ce4848f092be44f3b3ff404e487d85e04438afa28f67a036f1fd9650c91b93625627bd6cac093895dbfe024492d86c3e36027b3637ec472245a46b1b3fd897a1a7e309421a13153636373806941b179ed5e743d0873d8935ef044eca6a40b138943a0d8d9240b298d1a246991ed0e059ed4f08aa0ac61a28364ce0d166713963703d0f64ec70658306ab1ee2c64bed1e16510e0b62e01e3a1a4e523ea5905685c6124e1b1b249341c091ae380c527324685bed1e24085976b0dc543dd8ce124e172596b19356376cd8d10b1b2ed1e2a3c0c9e2c48c5a859592d704fc09f9e8230c826d6363d88a18b0a088e46d967da3c6c124c4d0e87124174622db2464659a189d0eda1b1d31881a7fa2cbd1c0d8b5448c3768f1a04cd6207f90a5f049ebf91c7248996a44be1a17b89079a7d0d7c33fea44cda811caffa841b0b10900d2cbf4852194b6f9164d24f2856bfb8f43375a353c9249c67243a7dabc3498489d0c44320f867af430e248e8f3f612aad8625ae4f026120281aa2216c81431cf1908ffe68993626ddb5e5248c510a4ecff7fc0f525b7420b0c2e3845fad0124771ee0b124271592f044cb82a5312eca5589150dc8bb47868c267299f85806a2db673bb9416c1dcbe0dc1e856364f5a3ec6bd9644291d06e8b5dfb0297e4e016ef3385da3c4892c2282648ff000231e137042e021e027ed7b191afdec260990ee4f68688271fc16217e588b2363795da3e84c84e84bdd0bd1bbe14ca2f439c9cbe18e5117a68455034781ed9bf02b8f92917b8218671d0bb47d6dd0641f2aca216a4c844b96165e5768fb54e18962d4b15b1e5e5768fb899c3df42ed1f7086fa5768fbe5da3ef976b0410410410410410410410410410410410410410411fe6dffda000c03010002000300000010fbefbefbefbefbefbefbefbefbefbefbefbefbee0e31efae938a98f4e38e398fbefbefbefbefa8f36fef87c6e79abe9afbcabefbefbefbefbea3ee6fded3f5c6ed2df5efaafbefbefbefbefa8926fcbaa7dacee82759feabefbefbefbefbefb96479f159bea1f723dc528fbefbefbefbefba8e72e3f4a739d7f093eaaabefbefbefbefbef82ffba27448307f79bcaf2afbefbefbefbefb932f8c2e1827397cfa22fd83efbefbefbefbefd3fd3f2419c7ecf38e65f6afbefbefbefbefb9ee3d1254ad7c33ce9d556abefbefbefbefbef3a4d97cef0d129d1bd6352afbefbefbefbefbeba9ad32b76ce499adebf7abefbefbefbefbefb93476a74f36ebe94d0dbe8fbefbefbefbefba931fd621a7d7079e7e8c0efefbefbefbefbeaad048c41f36f754cff5c1c0fbefbefbefbefa8a74ceac6d536c865dd728ebefbefbefbefbea2a48b7ce83d606a57dd1c74fbefbefbefbefa8e9ee38f3cfbcf14401dd5c7efbefbefbefbea3b5cf87cf3cbf5a0a97af2afbefbefbefbefa8f2df4cf3cf3c7cc74b57dabefbefbefbefbea3cf3cf3cf3cf3cf0d81d76afbefbefbefbefa8f3cf3cf3cf3cf3cf2c77cabefbefbefbefbeb32cb2cb2cb2cb2cb2cb2ca4fbefbefbefbefbefbefbefbefbefbefbefbefbefbefbefbefbffc4001f1101000202020301010000000000000000010011213110302041514050ffda0008010301013f10fdf72e5cb972ff0015f854ae6ff03e016d10f0f7a1c3c5fe261e7f50a62210fb0db4f03b5f06169130a51098c5b544a6a3c1f89a2f72c3052a6546e8fe44381df04608e1716db8f73e072e5a842926e9e275be08e3505c3639af1f888d30eb791a2dea0152983113a22561f0601a8201a84e1cf731ab800f9e107700a32472cca2f9dcb7d46b9d4ad4ba2c9b9318d3d8cce8cb1621c2c9b18bb2096152b2418c47ea674567d8c361f20ca1b9ec32f82ddda50660241461352b564b43a81920a51ec7b3e46fd4d4b97e4c035085fb15c5295162216710587ac2d080494f9c0048707d27c21954a31116c0cb1b876001229c0619960bf61c4a63860e6f806ee62a20409757b20c547b90552c34a369049a7620d449b220348236970a9ec8e2baf5c0054ba509e24b3085f5a944b22d618ad67a11db7d75f00fb966a633c2a1852de4cb106f42ab82a53aed14d4d7b14b678e9202512e6d658d44a895f9aea32aa6045bfcfa8abbfeefffc4002111000300030101010002030000000000000001111021313020414051507181ffda0008010201013f10fe53362442111111111110689a365179316217e1b8274b96b0bc98b821e5b8ab3907374704ee261a179ae122ca3fef0d0b6c6d462732c685e4be9942634461da0c8c7e66af47f14668244866264d1b242c218bcedf86d8a9100c4da37a58eb08635bf243df32dcc2634763a5470709c13a218fc91fef2a4560e8a8d3e2140c98c7e4bb99690db78fcde1baa6641bbb23a6265f25d19251bbf2093f7135fc18d590e8b28c5e484553ca1b4c68c5e48b0ddbc9699a6cfd36f243e1d6141c9af859945a1e98d579b635b2091c7c5c70ea174e86df9329683651323c0d3584bd11d0cebc99ba1aa4106ffa52d14e1fdc49814fc10b7c12123f27999f95f36710e069d25d92227998d55069e136be1aa86b53420d1ba85a5882f27968cd5df9693206bfa16b2bc9fa3595e4fd7985e7084210842108421082ff0005ffc4002810010002020104020202030101000000000100112131411051617140812091a1b13050c1d160ffda0008010100013f10ff00e9d6bf200dfe15f955caae8f45ae3fc20037f1da7a540afc6965ef329e625a287bc1c128ad33ee2dbfe7e0ee557e7a7c857e22190b89a0ba89032bc17e638608724c10475d02e5819b962ba25c4a3f3d3e2aba57e0965d5405dc068c8a878d3646d6d816d3fb8f84c32bb4b4e60b986a4ab6c579621a8aa4894d73d12257e3a7c61bebdc4b99cf46d22129cea2ab6e653da51039e62eac52d75cb0a26962977ec882d1c82fef8ea8ac95f79ed0df438bea971c7e1a7c51b981be816c08b671d0c4b0471c4b778e8ee31e014c82e5fa2dfa876c0d9a56bbb12a7a0a8acc08858fb96c92d2dbe5ff0088884418478e8d711068f6a8b45c2145fe095f869f146e55b2a599e481da251885e9558663953b4226653019aa2bc32dfe90fb8ea98351ea69c54f58095850d1b38ee306f378e73adb0fbeb85514951a34e209837d52e2575d3e28df5255f782e564bb802ef2bc18819a888e610b1ca33d0201b856d4c5a54529ab98c701c0525892094a8b41d556c317c41e7c3495645ad7dc21452d1fc1e954f680bbbc22a2b63f703aad44762ba25f5d3e273d42d82809cccb5a5620a6f72c47845a78d332a43dc723643ed97a5c5d6860dc802be4994656303ec57b84b28d082dfbfb976548b365988fd474dda5502d75796ad5a838a96a1697cb08e032f0418ac68d3d2e672731038881cdc0b8bb1fc5a7c4e4e8278949072812c982e545d99fce82eed1292daaf622ed639b2387daa1c1ca162b11e478d7b8460b0a29cad597d504bacf2261835995965f42082c82d8c4039b86568fede96a3a63b6ce22095db12d1d54415e99788f4d3e27274a1efa0314bcc1a088acf797a2da3716ee5d9e4890e832fc37096c2352b77f3e20784dd638ed2caedc95f4ba3f6c104c60dcd36fee311aaadef310be4d3ff679d3779e8a87b858b6423692822d2da3a61aead3e238a816d41412d7389a211cdfd4c10422d7ad6271e6205b489d8121c237ff0022ad38391e4942aef9812c02e324455859107683d80e8b6fc47fda1df6105afdcb650676db23f7102ec01f75d150f6963ef3140e599151437ee2b49d174d3e2a471b8ad9fbea6b1b833da0692843ed8e983b9752ae2614d0945fa96c672db64b46b4be4dca7bc92b51c0a852b818c8cd07d858ca43014ec761ff00b0414998bda723083d5e3f8eb89ca45d89f772ab5a883b8add54a958e9a7c51a46109ef0c9d0f10e61ccdbde2e7a30732f221f6466ca555015b17f4c3653bb562427153921a155b210f6d467372baf28d1baa6dfc1d4c67bc6957f51d3d1df47516db87c505704bde10c1bb817e20020aa22a58bcc18be655308985cbba584b458b2e9e5c4055732e29f1a4bb38ee37082f988e160868763f0a9621682a6986e30523aa5334f8809b8b2edd04aee3bf28ef1a8b98f58d31b9d972fede94bc9fa80e2c4ed2ae133aa8e977f515dd52cfcb4968855152a960cbf069f1399ce26a32f98241c1b8954ee144d21d7c9a633567d408507748509a4b17982abcc486f750a068637bac5f44bfc557d1578ed0508045e7aad43e205b34208718265b3119fe854c2547c2620977940d6ecc1ff00b001f45b83d3764ae238837f86ba64e834df4189616a591ece2b88d558836757534f89abaacc6b0dc28d8ab588821f3300f1e6603995b99a72d6ed8435a8188576489b7163352b39c7e1f771a8b8fc092bb8460e37089fd4552c3b2131d3a8751af8834f4ab828d99fb8555d54307a7797bca40faf5020ff005132dbdc5b2d1da549fc92c482f43146ade934b0c2a0d23d6ee547712ba05b148929cc2845fa2020dee076dc4ae86a573e22375a65c7734f89ccaf79976b6e98ae6c3c021e041a9450c4cd970f11695e61af3da08c00ca030f9b94143bef88b4723494655da2815f925d745e9696bf8802a2bc15820d1aad6a50ac04701de0e0f128ad494f6b83ce3a387ae9f13989a40d255660674d8f2cad393bc409057f73159dc2c653dc7825c0514ec8bebda25fc1f0c0d7f6aa58725bc648ba87e26acb7e081b7e73c987c4a4c85ec4458c2c4d1799aba2d10de54883b089fa067c310952ba69f139e83504a6c1f52a641412dd7041038855b51c2cf26205cf1ea19aa8a83798d5af37b8f116e5546c55db102f0138a2a039b61912c28a0a634900d52e7285941f512ba6fb3da596e6e590868d8846a2dc11f266f985700864efd34f89cf5bc62c52ec4d9e65f957a851ce654d42ec7230a5eae14459caa24bc9ea34b5ee0afb4556349962534ea39e94764b0597456bccab6efbca56b8fea18a32411e1da22f37cf989ee4b0f19b235037943a55d0d44dcf588ed9a7c4e7ad5ac584af315a1043e359839dcb5b4a3c426859ee24c6d134bed9862c4494b8a3cb0c627d92e336ece254b2afdc1d8a878abb95b8949a4da93095951283be4ef2cb819ef02348e9f0e276258623a4ecc5b334b981603e89b469f139ea14ace4c3c170d9710e405f762edbe25fabb8c704f3334fa0dcb9a0ef0f201f50c11abec4025531dc829a1017051dd505cdce98231f4ba86e50e6a1134120f3287f8950030ff70b19b7a4c14e7b4c308a8b96fee8834f98ac7c573d0772e2e30fea56d9c9aa8dd34ef095414c22aae398964aed1de8a678622c150607f423651ee01e32fb1fb8ab2ca8957b214179778c73623dad31a980d66a5abcc500fd4c48c77789ee4b1f1921a2599e1d4b6bb310cdfc50f799b254ad5431f52f7435282728aa3423558e7fa94cb6ed11414580755a96a931e2089716c5c015711793f5006d8972bfb9cacb96a31e2347bf31aded859bc1788a00c11a1790f5311789e2172ec7a869dc8157f18b2134ae88d586bdc34cb701707311bcc963b95a1bb7352a7621bdc1a8d4425f98dc488b6102f0b72974f1296e2daf517d264818d5d6ee5f38330854a923ee08a430c8ca1b953ad7c6793182402ced967200f333e83b5cd9238ed04d83f73011a409c3151e8cc4fa441cdcc744bc50838ee4b8ec46cdf1da5461542d4c3370aaff0032dc9b2161b8ce6e9962262aadc32b84ad4a3e3439b778981dbde1400d2f68d56a885c1922a6bb3988a95b97db82b3286c198079d439e080e7333718895dc45c388d439e8dbc4a6988f3646a845f8998ff00916ee6a4ab06e0a93f1717ea5be30057b5fc432b55de5222bbeccf35f132aee4a6efb401b8a8c14cac515543370f0a5a6d73030cb3ccdb1c186b2c56cd311a1315abbe2193024a9d97504bcdce138975ff00b8d020bf10176dbe63a3e30d25d62a721925caadf2c2e75897e920a4fb0431e5f040d2dc44562646c2a1e505bab8b12916def12e6475055de2b2d5dc43005698acc51ea039510052b6d12d751d927283ab7da216167a99e4c315339973f1873328cdc13561dd88395f027843c6e586c068615b0c8bb95ee176629cff00222934f6413802f7980a2ed94e1b7dca505e378fda30553c389862aed94aa20f157505b63cd47bf30999d9c31d4a2e1e04e03a84420c4b0a52f386c37b41d2c52d6e4727c6683c90b6632d9c7b88457d9f1d70f3a804b733128aa941d4d1599b210ad3c5757f21334702fe418a00371b50c19c97c3ea225d8ee17b879626e2520384e62d5308eee286553b117841d68d4695a629bdf2b5dd87f88a4aed6e3a86cc64b8ac87c6569bef0a6a5b6e08b50540e660bf68819ab1fe00f6dd0396330b0937ff00a3028e1405dc2cf3b201e5e20f3cca16dfb79fb98d1b5553f73621ac460506f11894165df329568513dbff00b18d18a2854d3e32d0ee74e0837ee0af399a88ad9d9ff02d7f555341ce7821816d4639fbed0b817707e2ff00b804ca6c87821e740db7cc177ae2668d1eccee8005b31791cb1a3a86b11e9cb161922cf78ecc82165adeecd4b888e669f18803881cee0711ee64161c896d3cff0082f1b35772a3b3b3466fef6b14044d96feb88e306c9bb735da0379a14dbee5d4f6badc96f292820b177823e2b7da9ff20d919ff133135c914cb8943445cf4d3e3ad2721fb9b8ccc22fd2354510dd94b667fc2b2b6566750e54b9d1ef71d24bc594fa8765205021d5be169896acbc40601bcd4c20fda71e1f11e112bae9f2c964911b2bfcbe6e61b90eb101b28cc05ea3b8b534eba7fa92586e115cdde21daa3820ae8d4a575d3fd585b9aa01598ebf069feb18232d7f1d3fd934ff0064d3e225fce0000000057ff6bfffd9, '7032447c449527aded922154489574ca'),
(270, 'Salah', 'Eddine', '2002-06-19', 'Alger', 'sohaib1@gmail.com', '$2y$10$wylOBeL.mfLDOuQM/BQBFuDI4afH3hLKt10MOc.yZUeJM1G7JJgdW', '0557743163', 'Parent', NULL, '6762e9ea803dc56a51aac30f0ff1b57d'),
(271, 'Bidjo', 'Salah', '2002-06-19', 'Alger', 'sohaib2@gmail.com', '$2y$10$.2yweTi4A02E60A6KNw5iuDacpm7grlCyr8yS/ogWMpTdK4z3I0ju', '0556814714', 'Élève', NULL, '0a362a09c8059f2e69b3393891941f3c'),
(272, 'Akram', 'Bidjo', '1995-07-23', 'Sidi GHilles', 'akram0@gmail.com', '$2y$10$.J51mi7GFEEGdxRNlxww.u9JbyRADDyj/KXop3ug/AnjR0IM7XimW', '0661565008', 'Élève', NULL, '165a30bb9d777bff5d523f19d9a56ab8');

--
-- Déclencheurs `utilisateur`
--
DELIMITER $$
CREATE TRIGGER `trg_after_insert_admin` AFTER INSERT ON `utilisateur` FOR EACH ROW BEGIN
    -- Check if the new user has userType 'Parent'
    IF NEW.userType = 'Admin' THEN
        -- Insert the new user's id into the parent table
        INSERT INTO admin (id) VALUES (NEW.id);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_after_insert_eleve` AFTER INSERT ON `utilisateur` FOR EACH ROW BEGIN
    -- Check if the new user has userType 'Parent'
    IF NEW.userType = 'Élève' THEN
        -- Insert the new user's id into the parent table
        INSERT INTO eleve (id) VALUES (NEW.id);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_after_insert_prof_principale` AFTER INSERT ON `utilisateur` FOR EACH ROW BEGIN
    -- Check if the new user has userType 'Parent'
    IF NEW.userType = 'ProfesseurP' THEN
        -- Insert the new user's id into the parent table
        INSERT INTO prof_principale (id) VALUES (NEW.id);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_after_insert_prof_simple` AFTER INSERT ON `utilisateur` FOR EACH ROW BEGIN
    -- Check if the new user has userType 'Parent'
    IF NEW.userType = 'Professeur' THEN
        -- Insert the new user's id into the parent table
        INSERT INTO prof_simple (id) VALUES (NEW.id);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_after_insert_utilisateur` AFTER INSERT ON `utilisateur` FOR EACH ROW BEGIN
    -- Check if the new user has userType 'Parent'
    IF NEW.userType = 'Parent' THEN
        -- Insert the new user's id into the parent table
        INSERT INTO parent (id) VALUES (NEW.id);
    END IF;
END
$$
DELIMITER ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`);

--
-- Index pour la table `eleve`
--
ALTER TABLE `eleve`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `enfant_parent`
--
ALTER TABLE `enfant_parent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `eleve_id` (`eleve_id`);

--
-- Index pour la table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `prof_principale`
--
ALTER TABLE `prof_principale`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `prof_simple`
--
ALTER TABLE `prof_simple`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `enfant_parent`
--
ALTER TABLE `enfant_parent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `eleve`
--
ALTER TABLE `eleve`
  ADD CONSTRAINT `eleve_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `enfant_parent`
--
ALTER TABLE `enfant_parent`
  ADD CONSTRAINT `enfant_parent_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parent` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enfant_parent_ibfk_2` FOREIGN KEY (`eleve_id`) REFERENCES `eleve` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `parent`
--
ALTER TABLE `parent`
  ADD CONSTRAINT `parent_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `prof_principale`
--
ALTER TABLE `prof_principale`
  ADD CONSTRAINT `prof_principale_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `prof_simple`
--
ALTER TABLE `prof_simple`
  ADD CONSTRAINT `prof_simple_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;