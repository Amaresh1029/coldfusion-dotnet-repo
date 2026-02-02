<form action="\assignment4\sort\result.cfm" method="post" class="sort-form">
    <label>Enter numbers (comma separated):</label><br>
    <input type="text" name="nums" placeholder="6,5,2,9,7" required>
    <br><br>
    <input type="submit" value="Submit">
</form>

<style>
    .sort-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .sort-form input {
        padding: 6px;
        margin-top: 6px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .sort-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .sort-form input[type="submit"]:hover {
        background: #45a049;
    }
</style>
