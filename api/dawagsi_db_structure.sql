-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  sam. 01 déc. 2018 à 20:06
-- Version du serveur :  5.6.41-log
-- Version de PHP :  7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `skydefrc_dawagsi`
--

-- --------------------------------------------------------

--
-- Structure de la table `Annotation`
--

CREATE TABLE `Annotation` (
  `id` int(11) NOT NULL COMMENT 'ID de l''annotation',
  `tag` varchar(100) NOT NULL COMMENT 'Tag de l''annotation',
  `position` text NOT NULL COMMENT 'Données de position de l''annotation'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Editor`
--

CREATE TABLE `Editor` (
  `id` int(11) NOT NULL COMMENT 'ID de l''éditeur',
  `name` varchar(100) NOT NULL COMMENT 'Nom de l''éditeur'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Image`
--

CREATE TABLE `Image` (
  `id` int(11) NOT NULL COMMENT 'ID de l''image',
  `originalName` varchar(100) NOT NULL COMMENT 'Nom original de l''image',
  `generatedName` varchar(100) NOT NULL COMMENT 'Nom md5 de l''image',
  `editor` int(11) DEFAULT NULL COMMENT 'ID de l''éditeur lié à l''image'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Image_Annotation`
--

CREATE TABLE `Image_Annotation` (
  `id` int(11) NOT NULL COMMENT 'ID de la liaison entre Image et Annotation',
  `image` int(11) NOT NULL COMMENT 'ID de l''image',
  `annotation` int(11) NOT NULL COMMENT 'ID de l''annotation'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Image_Relation`
--

CREATE TABLE `Image_Relation` (
  `id` int(11) NOT NULL COMMENT 'ID de la liaison entre Image et Relation',
  `image` int(11) NOT NULL COMMENT 'ID de l''image',
  `relation` int(11) NOT NULL COMMENT 'ID de la relation'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `List`
--

CREATE TABLE `List` (
  `id` int(11) NOT NULL COMMENT 'ID de la liste',
  `name` varchar(100) NOT NULL COMMENT 'Nom de la liste',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description de la liste'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `List_Image`
--

CREATE TABLE `List_Image` (
  `id` int(11) NOT NULL COMMENT 'ID de la liaison entre List et Image',
  `list` int(11) NOT NULL COMMENT 'ID de la liste',
  `image` int(11) NOT NULL COMMENT 'ID de l''image'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Relation`
--

CREATE TABLE `Relation` (
  `id` int(11) NOT NULL COMMENT 'ID de la relation',
  `predicate` varchar(100) NOT NULL COMMENT 'Prédicat de relation',
  `annotation1` int(11) NOT NULL COMMENT 'ID de la première annotation de la relation',
  `annotation2` int(11) NOT NULL COMMENT 'ID de la seconde annotation de la relation'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Annotation`
--
ALTER TABLE `Annotation`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Editor`
--
ALTER TABLE `Editor`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Image`
--
ALTER TABLE `Image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Image_ibfk_1` (`editor`);

--
-- Index pour la table `Image_Annotation`
--
ALTER TABLE `Image_Annotation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `image` (`image`,`annotation`),
  ADD KEY `Image_Annotation_ibfk_2` (`annotation`);

--
-- Index pour la table `Image_Relation`
--
ALTER TABLE `Image_Relation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `image` (`image`,`relation`),
  ADD KEY `Image_Relation_ibfk_2` (`relation`);

--
-- Index pour la table `List`
--
ALTER TABLE `List`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `List_Image`
--
ALTER TABLE `List_Image`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `list` (`list`,`image`),
  ADD KEY `List_Image_ibfk_2` (`image`);

--
-- Index pour la table `Relation`
--
ALTER TABLE `Relation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Relation_ibfk_1` (`annotation1`),
  ADD KEY `Relation_ibfk_2` (`annotation2`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Annotation`
--
ALTER TABLE `Annotation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de l''annotation';

--
-- AUTO_INCREMENT pour la table `Editor`
--
ALTER TABLE `Editor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de l''éditeur';

--
-- AUTO_INCREMENT pour la table `Image`
--
ALTER TABLE `Image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de l''image';

--
-- AUTO_INCREMENT pour la table `List`
--
ALTER TABLE `List`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la liste';

--
-- AUTO_INCREMENT pour la table `Relation`
--
ALTER TABLE `Relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de la relation';

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Image`
--
ALTER TABLE `Image`
  ADD CONSTRAINT `Image_ibfk_1` FOREIGN KEY (`editor`) REFERENCES `Editor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Image_Annotation`
--
ALTER TABLE `Image_Annotation`
  ADD CONSTRAINT `Image_Annotation_ibfk_1` FOREIGN KEY (`image`) REFERENCES `Image` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Image_Annotation_ibfk_2` FOREIGN KEY (`annotation`) REFERENCES `Annotation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Image_Relation`
--
ALTER TABLE `Image_Relation`
  ADD CONSTRAINT `Image_Relation_ibfk_1` FOREIGN KEY (`image`) REFERENCES `Image` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Image_Relation_ibfk_2` FOREIGN KEY (`relation`) REFERENCES `Relation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `List_Image`
--
ALTER TABLE `List_Image`
  ADD CONSTRAINT `List_Image_ibfk_1` FOREIGN KEY (`list`) REFERENCES `List` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `List_Image_ibfk_2` FOREIGN KEY (`image`) REFERENCES `Image` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Relation`
--
ALTER TABLE `Relation`
  ADD CONSTRAINT `Relation_ibfk_1` FOREIGN KEY (`annotation1`) REFERENCES `Annotation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Relation_ibfk_2` FOREIGN KEY (`annotation2`) REFERENCES `Annotation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
