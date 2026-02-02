<form action="\assignment4\calculator\result.cfm" method="post" class="calc-form">
    <input type="text" name="num1" placeholder="Number 1" required>
    <select name="op">
        <option value="+">+</option>
        <option value="-">-</option>
        <option value="*">*</option>
        <option value="/">/</option>
    </select>
    <input type="text" name="num2" placeholder="Number 2" required>
    <input type="submit" value="=">
</form>

<style>
    .calc-form {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .calc-form input,
    .calc-form select {
        padding: 6px 8px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .calc-form input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .calc-form input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>
