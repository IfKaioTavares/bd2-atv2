INSERT INTO public.categories (id, name, description, parent_id, created_at, updated_at, deleted) VALUES
-- Categorias principais
(1, 'Vestuário', 'Roupas e acessórios', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(2, 'Calçados', 'Tênis, sapatos e outros calçados', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(3, 'Eletrônicos', 'Dispositivos eletrônicos e acessórios', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(4, 'Alimentos', 'Produtos alimentícios', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(5, 'Eletrodomésticos', 'Aparelhos para casa', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(6, 'Beleza', 'Produtos de beleza e cuidados pessoais', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(7, 'Brinquedos', 'Brinquedos e jogos', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(8, 'Ferramentas', 'Ferramentas e equipamentos', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(9, 'Esportes', 'Artigos esportivos', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(10, 'Material Escritório', 'Materiais de escritório e papelaria', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(11, 'Pet Shop', 'Produtos para animais de estimação', NULL, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Vestuário
(12, 'Camisetas', 'Camisetas e regatas', 1, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(13, 'Calças', 'Calças e shorts', 1, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(14, 'Casacos', 'Casacos e jaquetas', 1, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(15, 'Acessórios', 'Acessórios de vestuário', 1, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Eletrônicos
(16, 'Computadores', 'Notebooks e desktops', 3, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(17, 'Smartphones', 'Telefones celulares', 3, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(18, 'TVs', 'Televisores', 3, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(19, 'Acessórios', 'Acessórios eletrônicos', 3, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Alimentos
(20, 'Bebidas', 'Refrigerantes, sucos e outras bebidas', 4, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(21, 'Doces', 'Chocolates e doces', 4, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(22, 'Laticínios', 'Leite, iogurtes e derivados', 4, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(23, 'Condimentos', 'Molhos e condimentos', 4, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Eletrodomésticos
(24, 'Cozinha', 'Eletrodomésticos para cozinha', 5, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(25, 'Lavanderia', 'Máquinas de lavar e secar', 5, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(26, 'Limpeza', 'Eletrodomésticos para limpeza', 5, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Beleza
(27, 'Maquiagem', 'Produtos de maquiagem', 6, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(28, 'Perfumaria', 'Perfumes e colônias', 6, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(29, 'Cuidados Pessoais', 'Produtos para cuidados pessoais', 6, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Brinquedos
(30, 'Bonecas', 'Bonecas e acessórios', 7, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(31, 'Carrinhos', 'Carrinhos e veículos de brinquedo', 7, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(32, 'Jogos', 'Jogos de tabuleiro e cartas', 7, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(33, 'Brinquedos Educativos', 'Brinquedos educativos', 7, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Ferramentas
(34, 'Ferramentas Elétricas', 'Ferramentas elétricas', 8, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(35, 'Ferramentas Manuais', 'Ferramentas manuais', 8, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(36, 'Automotivo', 'Ferramentas e peças automotivas', 8, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Esportes
(37, 'Fitness', 'Equipamentos para fitness', 9, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(38, 'Suplementos', 'Suplementos alimentares', 9, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(39, 'Esportes Aquáticos', 'Equipamentos para esportes aquáticos', 9, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Material de Escritório
(40, 'Papelaria', 'Materiais de papelaria', 10, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(41, 'Escrita', 'Canetas, lápis e marcadores', 10, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(42, 'Organização', 'Materiais de organização', 10, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),

-- Subcategorias de Pet Shop
(43, 'Cães', 'Produtos para cães', 11, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(44, 'Gatos', 'Produtos para gatos', 11, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(45, 'Aves', 'Produtos para aves', 11, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false),
(46, 'Peixes', 'Produtos para peixes', 11, '2025-03-30 00:00:00+00', '2025-03-30 00:00:00+00', false);