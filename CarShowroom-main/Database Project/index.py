import os
from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector

""" Insert your Database name, Username and Password here bellow """
database_name = 'car_showroom'
database_username = 'root'
database_password = 'root'

try:
    conn = mysql.connector.connect(host='localhost', user=database_username, password=database_password, database=database_name)
    if conn.is_connected():
        print("Connection established...")

    else:
        print("Connection failed.")

except mysql.connector.Error as e:
    print("Error connecting to MySQL:", e)

app = Flask(__name__)
app.secret_key = '1211441'

images_path = "static/images/"
UPLOAD_FOLDER = 'static/images'
ALLOWED_EXTENSIONS = {'jpg', 'jpeg'}
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


# Define routes
@app.route('/')
def index():
    session['logged_in'] = False
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Car WHERE is_Sold = 0 AND is_Reserved = 0")
    cars = cursor.fetchall()  # Retrieve all rows from the query result
    cursor.close()
    num_of_cars = len(cars)

    for car in cars:
        car['image'] = images_path + car['ChassisNumber'] + ".jpg"
    return render_template('index.html', cars=cars, num_of_cars=num_of_cars)


@app.route('/contact_us')
def contact_us():
    session['logged_in'] = False

    return render_template('contact_us.html')


@app.route('/about_us')
def about_us():
    session['logged_in'] = False

    return render_template('about_us.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if username == "Moaid" and password == "1211441":
            session['logged_in'] = True
            return redirect(url_for('insert_car'))

        elif username == "Qusay" and password == "1212508":
            session['logged_in'] = True
            return redirect(url_for('insert_car'))

        elif username == "Aseel" and password == "1221024":
            session['logged_in'] = True
            return redirect(url_for('insert_car'))

        elif username == "Deema" and password == "1220002":
            session['logged_in'] = True
            return redirect(url_for('insert_car'))

        else:
            return render_template('login.html')
    else:
        return render_template('login.html')


@app.route('/show_car', methods=['GET', 'POST'])
def show_cars():
    if session.get('logged_in'):
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Car")
        cars = cursor.fetchall()  # Retrieve all rows from the query result
        cursor.close()
        for car in cars:
            car['image'] = images_path + car['ChassisNumber'] + ".jpg"
            flags_converter(car)

        return render_template('show_car.html', cars=cars)
    else:
        return redirect(url_for('login'))


@app.route('/show_reserved_car', methods=['GET', 'POST'])
def show_reserved_cars():
    if session.get('logged_in'):
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Car JOIN Customer ON Car.SSN = Customer.SSN WHERE is_Reserved = 1")
        cars = cursor.fetchall()  # Retrieve all rows from the query result
        cursor.close()
        for car in cars:
            car['image'] = images_path + car['ChassisNumber'] + ".jpg"
            flags_converter(car)

        return render_template('show_sold_reserved_car.html', cars=cars)
    else:
        return redirect(url_for('login'))


@app.route('/show_sold_car', methods=['GET', 'POST'])
def show_sold_cars():
    if session.get('logged_in'):
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Car JOIN Customer ON Car.SSN = Customer.SSN WHERE is_Sold = 1")
        cars = cursor.fetchall()  # Retrieve all rows from the query result
        cursor.close()

        for car in cars:
            car['image'] = images_path + car['ChassisNumber'] + ".jpg"
            flags_converter(car)

        return render_template('show_sold_reserved_car.html', cars=cars)
    else:
        return redirect(url_for('login'))


def flags_converter(car):
    if car['is_Reserved'] == 1:
        car['is_Reserved'] = 'Yes'
    else:
        car['is_Reserved'] = 'No'
    if car['is_Sold'] == 1:
        car['is_Sold'] = 'Yes'
    else:
        car['is_Sold'] = 'No'


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/insert', methods=['GET', 'POST'])
def insert_car():
    if session.get('logged_in'):
        if request.method == 'GET':
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM employee")
            employees = cursor.fetchall()  # Retrieve all rows from the query result
            cursor.close()
            for employee in employees:
                if employee['Name'] == "Qusay Taradeh":
                    employee['image'] = "static/images/Qusay.jpg"
                elif employee['Name'] == "Aseel Abd Elhaq":
                    employee['image'] = "static/images/Aseel.jpg"
                elif employee['Name'] == "Moaid Karakra":
                    employee['image'] = "static/images/Moaid.jpg"
                elif employee['Name'] == "Deema Abu Nimeh":
                    employee['image'] = "static/images/Deema.jpg"

            return render_template('database.html', employees=employees)

        elif request.method == 'POST':
            chassis_num = request.form['chassis_num']
            car = request.form['car']
            motor_size = request.form['motor_size']
            fuel = request.form['fuel']
            transmission = request.form['transmission']
            color = request.form['color']
            model = request.form['model']
            year = request.form['year']
            price = request.form['price']
            branch_number = request.form['branch_number']

            if 'car_image' not in request.files or 'chassis_num' not in request.form:
                return redirect(url_for('insert_car'))

            file = request.files['car_image']
            chassis_number = request.form['chassis_num'].strip()

            if file.filename == '' or not allowed_file(file.filename):
                return redirect(url_for('insert_car'))

            new_filename = f"{chassis_number}.jpg"
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], new_filename)
            file.save(file_path)

            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO Car (Color, Price, ReleaseYear, Model, MotorSize, FuelType, TransmissionType, ChassisNumber, ManufacturingCompany, BranchNumber) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);",
                (str(color), float(price), int(year), str(model), float(motor_size), str(fuel),
                 str(transmission), str(chassis_num), str(car), str(branch_number)))

            conn.commit()
            cursor.close()
            return redirect(url_for('insert_car'))
    else:
        return redirect(url_for('login'))


@app.route('/delete', methods=['GET', 'POST'])
def delete_car():
    if session.get('logged_in'):
        if request.method == 'GET':
            return render_template('database.html')
        elif request.method == 'POST':
            chassis_num = request.form['chassis_num']
            cursor = conn.cursor()
            cursor.execute("DELETE FROM Car WHERE ChassisNumber = %s", (chassis_num,))
            conn.commit()
            cursor.close()
            return redirect(url_for('insert_car'))
    else:
        return redirect(url_for('login'))


@app.route('/update', methods=['GET', 'POST'])
def update_car():
    if session.get('logged_in'):
        if request.method == 'GET':
            return render_template('database.html')
        elif request.method == 'POST':
            # Fetch form data
            chassis_num = request.form['chassis_num']

            # Fetch original values from the database
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM Car WHERE ChassisNumber = %s", (chassis_num,))

            car_data = cursor.fetchone()
            cursor.close()

            # Update only the attributes provided in the form
            color = request.form.get('color', car_data['Color'])
            price = request.form['price']
            if price == '':
                price = car_data['Price']

            year = request.form['year']
            if year == '':
                year = car_data['ReleaseYear']
            model = request.form.get('model', car_data['Model'])
            motor_size = request.form.get('motor_size', car_data['MotorSize'])
            fuel = request.form.get('fuel', car_data['FuelType'])
            transmission = request.form.get('transmission', car_data['TransmissionType'])
            car = request.form.get('car', car_data['ManufacturingCompany'])
            branch_number = request.form.get('branch_number', car_data['BranchNumber'])
            ssn = request.form.get('ssn', car_data['SSN'])

            motor_size = int(motor_size)

            cursor = conn.cursor()
            cursor.execute(
                "UPDATE Car SET Color=%s, Price=%s, ReleaseYear=%s, Model=%s, MotorSize=%s, FuelType=%s, TransmissionType=%s, ManufacturingCompany=%s, BranchNumber=%s, SSN=%s WHERE ChassisNumber=%s",
                (str(color), price, year, str(model), motor_size, str(fuel),
                 str(transmission), str(car), str(branch_number), str(ssn), str(chassis_num)))

            conn.commit()
            cursor.close()
            return redirect(url_for('insert_car'))
    else:
        return redirect(url_for('login'))


@app.route('/<string:chassis_number>')
def car_details(chassis_number):
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Car WHERE ChassisNumber = %s", (chassis_number,))
    car = cursor.fetchone()
    cursor.close()
    car_image = images_path + car['ChassisNumber'] + ".jpg"
    car['image'] = car_image

    return render_template('car.html', car=car)


@app.route('/filter_cars', methods=['GET'])
def filter_cars():
    manufacturing_company = request.args.get('car')
    model = request.args.get('model')
    year = request.args.get('year')
    price = request.args.get('price')
    color = request.args.get('color')
    fuel = request.args.get('fuel')
    transmission = request.args.get('transmission')
    motor_size = request.args.get('motor_size')
    chassis_number = request.args.get('chassis_number')
    branch_number = request.args.get('branch_number')
    owner_ssn = request.args.get('owner_ssn')
    reserved = request.args.get('reserved')
    sold = request.args.get('sold')

    # Apply filters to the database query
    filtered_cars = get_filtered_cars(manufacturing_company, model, year, price, color, fuel, transmission, motor_size,
                                      chassis_number, branch_number, owner_ssn, reserved, sold)

    # Check if any cars meet the criteria
    if not filtered_cars:
        message = "No cars meet the specified criteria."
        return render_template('index.html', message=message)

    num_of_cars = len(filtered_cars)

    for car in filtered_cars:
        car['image'] = images_path + car['ChassisNumber'] + ".jpg"
    return render_template('index.html', cars=filtered_cars, num_of_cars=num_of_cars)


def get_filtered_cars(manufacturing_company, model, year, price, color, fuel, transmission, motor_size, chassis_number,
                      branch_number, owner_ssn, reserved, sold):
    query = "SELECT * FROM car WHERE 1=1"
    params = []

    if manufacturing_company:
        query += " AND ManufacturingCompany = %s"
        params.append(manufacturing_company)
    if model:
        query += " AND Model = %s"
        params.append(model)
    if year:
        query += " AND ReleaseYear = %s"
        params.append(year)
    if price:
        query += " AND Price <= %s"
        params.append(price)
    if color:
        query += " AND Color = %s"
        params.append(color)
    if fuel:
        query += " AND FuelType = %s"
        params.append(fuel)
    if transmission:
        query += " AND TransmissionType = %s"
        params.append(transmission)
    if motor_size:
        query += " AND MotorSize = %s"
        params.append(motor_size)
    if chassis_number:
        query += " AND ChassisNumber = %s"
        params.append(chassis_number)
    if branch_number:
        query += " AND BranchNumber = %s"
        params.append(branch_number)
    if owner_ssn:
        query += " AND SSN = %s"
        params.append(owner_ssn)
    if reserved:
        query += " AND is_Reserved = %s"
        params.append(reserved)
    if sold:
        query += " AND is_Sold = %s"
        params.append(sold)

    cursor = conn.cursor(dictionary=True)
    cursor.execute(query, params)
    results = cursor.fetchall()
    conn.commit()
    cursor.close()

    return results


# Route for booking a car
@app.route('/book_car/<chassis_number>', methods=['POST'])
def book_car(chassis_number):
    if request.method == 'POST':
        ssn = request.form['ssn']
        name = request.form['name']
        address = request.form['address']
        phone = request.form['phone']

        cursor = conn.cursor(dictionary=True)

        # Check if the customer already exists
        cursor.execute("SELECT * FROM Customer WHERE SSN = %s", (ssn,))
        existing_customer = cursor.fetchone()

        # If the customer doesn't exist, insert them into the database
        if not existing_customer:
            cursor.execute("INSERT INTO Customer (SSN, Name, Address, Phone) VALUES (%s, %s, %s, %s)",
                           (ssn, name, address, phone))

        cursor.execute("UPDATE car SET is_Reserved = 1, SSN = %s WHERE ChassisNumber = %s", (ssn, chassis_number))
        cursor.execute("UPDATE car SET SSN = %s WHERE ChassisNumber = %s", (ssn, chassis_number,))

        conn.commit()
        cursor.close()
        return redirect(url_for('index'))


@app.route('/buy_car/<chassis_number>', methods=['POST'])
def buy_car(chassis_number):
    if request.method == 'POST':
        ssn = request.form['ssn']
        name = request.form['name']
        address = request.form['address']
        phone = request.form['phone']

        cursor = conn.cursor(dictionary=True)

        # Check if the customer already exists
        cursor.execute("SELECT * FROM Customer WHERE SSN = %s", (ssn,))
        existing_customer = cursor.fetchone()

        # If the customer doesn't exist, insert them into the database
        if not existing_customer:
            cursor.execute("INSERT INTO Customer (SSN, Name, Address, Phone) VALUES (%s, %s, %s, %s)",
                           (ssn, name, address, phone))
        cursor.execute("UPDATE car SET is_Sold = 1 WHERE ChassisNumber = %s", (chassis_number,))
        cursor.execute("UPDATE car SET SSN = %s WHERE ChassisNumber = %s", (ssn, chassis_number,))

        conn.commit()
        cursor.close()
        return redirect(url_for('index'))


# Route to reset sold cars based on chassis number
@app.route('/reset_sold', methods=['POST'])
def reset_sold_cars():
    if request.method == 'POST':
        chassis_number = request.form['chassis_number']
        cursor = conn.cursor()
        cursor.execute("UPDATE car SET SSN = NULL WHERE ChassisNumber = %s;", (chassis_number,))
        cursor.execute("UPDATE Car SET is_Sold = 0 WHERE ChassisNumber = %s", (chassis_number,))
        conn.commit()
        cursor.close()
    session['logged_in'] = True
    return redirect(url_for('insert_car'))


# Route to reset reserved cars based on chassis number
@app.route('/reset_reserved', methods=['POST'])
def reset_reserved_cars():
    if request.method == 'POST':
        chassis_number = request.form['chassis_number']
        cursor = conn.cursor()
        cursor.execute("UPDATE car SET SSN = NULL WHERE ChassisNumber = %s;", (chassis_number,))
        cursor.execute("UPDATE Car SET is_Reserved = 0, SSN = NULL WHERE ChassisNumber = %s", (chassis_number,))
        conn.commit()
        cursor.close()
    session['logged_in'] = True
    return redirect(url_for('insert_car'))


if __name__ == '__main__':
    app.run(debug=True)