#!/bin/bash
yum install -y httpd
systemctl start httpd
systemctl enable httpd
instance_id=$(ec2-metadata -i | cut -d --delimiters=' ' -f 2)
private_ip=$(ec2-metadata -o | cut -d ' ' -f 2)
az_name=$(ec2-metadata -z | cut -d ' ' -f 2)
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈쇼핑 메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
            transition: background-color 0.3s, color 0.3s;
        }

        body.dark-mode {
            background-color: #333;
            color: #f4f4f4;
        }

        header {
            background-color: #2874f0;
            color: white;
            padding: 20px;
            text-align: center;
        }

        header.dark-mode {
            background-color: #444;
        }

        header .search-bar {
            margin-top: 10px;
            display: flex;
            justify-content: center;
        }

        header .search-bar input[type="text"] {
            width: 300px;
            padding: 10px;
            border: none;
            border-radius: 5px;
        }

        header .search-bar button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-left: 5px;
            background-color: #fff;
            color: #2874f0;
            cursor: pointer;
        }

        header .search-bar button:hover {
            background-color: #ddd;
        }

        header .mode-toggle {
            margin-top: 10px;
            cursor: pointer;
            color: #2874f0;
            background-color: #fff;
            border: 2px solid #2874f0;
            padding: 5px 10px;
            border-radius: 5px;
        }

        header.dark-mode .mode-toggle {
            color: #fff;
            background-color: #444;
            border: 2px solid #f4f4f4;
        }

        main {
            padding: 20px;
        }

        .filter-sort {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-sort select {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .product-grid {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
        }

        .product {
            background-color: white;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            width: 30%;
        }

        .product.dark-mode {
            background-color: #444;
        }

        .product:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .product p {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }

        footer {
            background-color: #2874f0;
            color: white;
            padding: 10px 0;
            text-align: center;
            margin-top: 40px;
        }

        footer.dark-mode {
            background-color: #444;
        }

        footer a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }

        footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .product-grid {
                flex-direction: column;
                align-items: center;
            }

            .product {
                width: 80%;
            }
        }
    </style>
</head>
<body>
    <header id="header">
        <h1>홈쇼핑</h1>
        <div class="search-bar">
            <input type="text" placeholder="상품 검색...">
            <button>검색</button>
        </div>
        <button class="mode-toggle" onclick="toggleDarkMode()">다크 모드 전환</button>
    </header>

    <main>
        <div class="filter-sort">
            <select id="filter" onchange="filterProducts()">
                <option value="">모든 상품</option>
                <option value="price-low-high">가격 낮은 순</option>
                <option value="price-high-low">가격 높은 순</option>
                <option value="rating-high-low">평점 높은 순</option>
            </select>
        </div>
        <section class="product-grid">
            <a href="product1.html" class="product">
                <p>상품 1</p>
            </a>
            <a href="product2.html" class="product">
                <p>상품 2</p>
            </a>
            <a href="product3.html" class="product">
                <p>상품 3</p>
            </a>
        </section>
    </main>

    <footer id="footer">
        <p>&copy; 2024 홈쇼핑. 모든 권리 보유.</p>
        <p>
            <a href="https://www.coupang.com" target="_blank">쿠팡</a> |
            <a href="https://www.naver.com" target="_blank">네이버</a> |
            <a href="https://www.amazon.com" target="_blank">아마존</a>
        </p>
    </footer>

    <script>
        function toggleDarkMode() {
            document.body.classList.toggle('dark-mode');
            document.getElementById('header').classList.toggle('dark-mode');
            document.querySelectorAll('.product').forEach(product => {
                product.classList.toggle('dark-mode');
            });
            document.getElementById('footer').classList.toggle('dark-mode');
        }

        function filterProducts() {
            var filterValue = document.getElementById('filter').value;
            console.log('필터링 기준:', filterValue);
        }
    </script>
</body>
</html>
EOF
