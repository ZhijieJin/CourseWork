#include "shape.hpp"



//Base class
//Please implement Shape's member functions
//constructor, getName()
//
//Base class' constructor should be called in derived classes'
//constructor to initizlize Shape's private variable 
Shape::Shape(string input_name) {
	name_ = input_name;
}

string Shape::getName() {
	return name_;
}


//Rectangle
//Please implement the member functions of Rectangle:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
Rectangle::Rectangle(double input_width, double input_length):Shape("Rectangle") {
	width_ = input_width;
	length_ = input_length;
}

double Rectangle::getWidth() {return width_;}
double Rectangle::getLength() {return length_;}

double Rectangle::getArea() {
	return width_ * length_;
}

double Rectangle::getVolume() {
	return 0;
}

Rectangle Rectangle::operator + (const Rectangle& other) {
	double new_width = width_ + other.width_;
	double new_length = length_ + other.length_;
	return Rectangle(new_width, new_length);
}

Rectangle Rectangle::operator - (const Rectangle& other) {
	double new_width = width_ - other.width_;
	(new_width < 0) ? (new_width = 0):new_width;
	double new_length = length_ - other.length_;
	(new_length < 0) ? (new_length = 0):new_length;
	
	return Rectangle(new_width, new_length);
}

//Circle
//Please implement the member functions of Circle:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
Circle::Circle(double input_radius):Shape("Circle") {
	radius_ = input_radius;
}

double Circle::getRadius(){return radius_;}

double Circle::getArea() {
	return M_PI * radius_ * radius_;
}

double Circle::getVolume() {
	return 0;
}

Circle Circle::operator + (const Circle& other) {
	double new_radius = radius_ + other.radius_;
	return new_radius;
}

Circle Circle::operator - (const Circle& other) {
	double new_radius = radius_ - other.radius_;
	if (new_radius < 0) {
		return Circle(0);	
	}
	return Circle(new_radius);
}

//Sphere
//Please implement the member functions of Sphere:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
Sphere::Sphere(double input_radius):Shape("Sphere") {
	radius_ = input_radius;
}

double Sphere::getRadius(){return radius_;}

double Sphere::getArea() {
	return M_PI * 4 * radius_ * radius_;
}

double Sphere::getVolume() {
	return 4.0/3.0 * M_PI * radius_ * radius_ * radius_;
}

Sphere Sphere::operator + (const Sphere& other) {
	double new_radius = radius_ + other.radius_;
	return new_radius;
}

Sphere Sphere::operator - (const Sphere& other) {
	double new_radius = radius_ - other.radius_;
	if (new_radius < 0) {
		return Sphere(0);
	}
	return Sphere(new_radius);
}


//Rectprism
//Please implement the member functions of RectPrism:
//constructor, getArea(), getVolume(), operator+, operator-
//@@Insert your code here
RectPrism::RectPrism(double input_width, double input_length, double input_height):Shape("RectPrism") {
	width_ = input_width;
	length_ = input_length;
	height_ = input_height;
}

double RectPrism::getWidth(){return width_;}
double RectPrism::getHeight(){return height_;}
double RectPrism::getLength(){return length_;}

double RectPrism::getArea() {
	return  2 * (length_ *  width_  + length_ * height_ + width_ * height_);
}

double RectPrism::getVolume() {
	return length_ * width_ * height_;
}

RectPrism RectPrism::operator + (const RectPrism& other) {
	double new_width = width_ + other.width_;
	double new_height = height_ + other.height_;
	double new_length = length_ + other.length_;
	return RectPrism(new_width, new_length, new_height);
}

RectPrism RectPrism::operator - (const RectPrism& other) {
	double new_width = width_ - other.width_;
	double new_height = height_ - other.height_;
	double new_length = length_ - other.length_;
	if (new_width < 0 || new_height < 0 || new_length < 0) {
		return RectPrism(0, 0, 0);
	}
	return RectPrism(new_width, new_length, new_height);
}
 
// Read shapes from test.txt and initialize the objects
// Return a vector of pointers that points to the objects 
vector<Shape*> CreateShapes(char* file_name){
	//@@Insert your code here
	string name;
	int index;
	ifstream ifs (file_name, std::ifstream::in);
	ifs >> index;
	vector<Shape*> shapes(index);
	cout << index;
	for (int i = 0; i < index; i++) {
		ifs >> name;
		cout << name;
		if (name == "Rectangle") {
			double width, length;
			ifs >> width >> length;
			shapes[i] = new Rectangle(width, length);
		}
		if (name == "Circle") {
			double radius;
			ifs >> radius;
			shapes[i] = new Circle(radius);
		}
		if (name == "Sphere") {
			double radius;
			ifs >> radius;
			shapes[i] = new Sphere(radius);
		}
		if (name == "RectPrism") {
			double width, height, length;
			ifs >> width >> height >> length;
			shapes[i] = new RectPrism(width, height, length);
		}
	}
	ifs.close();
	
	return shapes; // please remeber to modify this line to return the correct value
}

// call getArea() of each object 
// return the max area
double MaxArea(vector<Shape*> shapes){
	double max_area = 0;
	//@@Insert your code here
	for (int i = 0; i < shapes.size(); i++) {
		if (shapes[i]->getArea() > max_area)
			max_area = shapes[i]->getArea();
	}
	return max_area;
}


// call getVolume() of each object 
// return the max volume
double MaxVolume(vector<Shape*> shapes){
	double max_volume = 0;
	//@@Insert your code here
	for (int i = 0; i < shapes.size(); i++) {
		if (shapes[i]->getVolume() > max_volume)
			max_volume = shapes[i]->getVolume();
	}
	
	return max_volume;
}

