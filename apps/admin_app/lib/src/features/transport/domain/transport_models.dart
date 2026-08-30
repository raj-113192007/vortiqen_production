class RouteStopInfo {
  final String stopName;
  final String scheduledTime;
  final bool isCompleted;
  final bool isCurrent;

  const RouteStopInfo({
    required this.stopName,
    required this.scheduledTime,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}

class StudentPassenger {
  final String name;
  final String studentClass;
  final String stop;
  final String boardedTime;
  final String status; // 'Boarded' or 'Absent'
  final String parent;
  final String phone;

  const StudentPassenger({
    required this.name,
    required this.studentClass,
    required this.stop,
    required this.boardedTime,
    required this.status,
    required this.parent,
    required this.phone,
  });

  bool get isBoarded => status.toLowerCase() == 'boarded';
}

class FuelLogEntry {
  final String id;
  final String date;
  final String busNumber;
  final String litres;
  final String cost;
  final String odometer;
  final String fuelPump;
  final String referenceNumber;

  const FuelLogEntry({
    required this.id,
    required this.date,
    required this.busNumber,
    required this.litres,
    required this.cost,
    required this.odometer,
    required this.fuelPump,
    required this.referenceNumber,
  });
}

class VehicleFleetInfo {
  final String id;
  final String busNumber;
  final String model;
  final int capacity;
  final String routeName;
  final int totalStops;
  final int totalScholars;
  final int onboardToday;
  final int absentToday;
  final String driverName;
  final String driverPhone;
  final String driverLicense;
  final String attendantName;
  final String attendantPhone;
  final String liveStatus;
  final String currentSpeed;
  final String currentLocation;
  final String etaToSchool;
  // Fuel & Servicing
  final String lastFuelDate;
  final String lastFuelQuantity;
  final String lastFuelCost;
  final String fuelMileage;
  final String lastServiceDate;
  final String nextServiceDate;
  final String fitnessExpiry;
  final String insuranceExpiry;
  final String pucExpiry;
  final List<RouteStopInfo> routeStops;
  final List<StudentPassenger> studentsOnboard;
  final List<FuelLogEntry> fuelLogs;

  const VehicleFleetInfo({
    required this.id,
    required this.busNumber,
    required this.model,
    required this.capacity,
    required this.routeName,
    required this.totalStops,
    required this.totalScholars,
    required this.onboardToday,
    required this.absentToday,
    required this.driverName,
    required this.driverPhone,
    required this.driverLicense,
    required this.attendantName,
    required this.attendantPhone,
    required this.liveStatus,
    required this.currentSpeed,
    required this.currentLocation,
    required this.etaToSchool,
    required this.lastFuelDate,
    required this.lastFuelQuantity,
    required this.lastFuelCost,
    required this.fuelMileage,
    required this.lastServiceDate,
    required this.nextServiceDate,
    required this.fitnessExpiry,
    required this.insuranceExpiry,
    required this.pucExpiry,
    this.routeStops = const [],
    this.studentsOnboard = const [],
    this.fuelLogs = const [],
  });

  bool get isMoving => liveStatus.toLowerCase().contains('transit') || liveStatus.toLowerCase().contains('moving');
  bool get isArrived => liveStatus.toLowerCase().contains('arrived') || liveStatus.toLowerCase().contains('campus');
  double get occupancyRate => totalScholars > 0 ? (onboardToday / totalScholars) : 0.0;
}

class TransportMockData {
  static List<VehicleFleetInfo> getFleet() {
    return [
      VehicleFleetInfo(
        id: 'vh_01',
        busNumber: 'DL 01 PB 4488 (Bus 04)',
        model: 'Tata Starbus Ultra (42-Seater AC)',
        capacity: 42,
        routeName: 'Route 04: Dwarka Sec 12 to School Campus',
        totalStops: 14,
        totalScholars: 38,
        onboardToday: 36,
        absentToday: 2,
        driverName: 'Mr. Surendra Pal',
        driverPhone: '+91 98111 55667',
        driverLicense: 'DL-0420188992 (Commercial HMV • Verified)',
        attendantName: 'Mr. Ramesh Yadav',
        attendantPhone: '+91 98222 66778',
        liveStatus: 'In Transit • GPS Active',
        currentSpeed: '34 km/h (Governor <40 km/h)',
        currentLocation: 'Janakpuri B-Block Flyover',
        etaToSchool: '7 mins',
        lastFuelDate: '26 Aug 2026',
        lastFuelQuantity: '65 Litres Diesel',
        lastFuelCost: '₹ 5,825.30',
        fuelMileage: '4.8 KM/L',
        lastServiceDate: '12 July 2026 (45K Overhaul)',
        nextServiceDate: '12 Oct 2026 (in 43 days)',
        fitnessExpiry: '15 March 2027 (Valid)',
        insuranceExpiry: '30 Nov 2026 (ICICI Lombard)',
        pucExpiry: '28 Feb 2027 (Valid)',
        routeStops: const [
          RouteStopInfo(stopName: 'Dwarka Sec 12', scheduledTime: '07:00 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Dwarka Sec 6', scheduledTime: '07:15 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Palam Colony', scheduledTime: '07:28 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Janakpuri B-Block', scheduledTime: '07:42 AM', isCompleted: false, isCurrent: true),
          RouteStopInfo(stopName: 'Vikaspuri More', scheduledTime: '07:50 AM', isCompleted: false),
          RouteStopInfo(stopName: 'School Campus', scheduledTime: '08:00 AM', isCompleted: false),
        ],
        studentsOnboard: const [
          StudentPassenger(name: 'Aarav Sharma', studentClass: 'Class 10-A', stop: 'Dwarka Sec 6', boardedTime: '07:18 AM', status: 'Boarded', parent: 'Rajesh Sharma', phone: '+91 98111 22334'),
          StudentPassenger(name: 'Ananya Iyer', studentClass: 'Class 10-A', stop: 'Palam Colony', boardedTime: '07:28 AM', status: 'Boarded', parent: 'Venkatesh Iyer', phone: '+91 98222 33445'),
          StudentPassenger(name: 'Rohan Mehta', studentClass: 'Class 10-A', stop: 'Janakpuri C-1', boardedTime: '--', status: 'Absent', parent: 'Sanjay Mehta', phone: '+91 98333 44556'),
          StudentPassenger(name: 'Kabir Kapoor', studentClass: 'Class 11-Sci', stop: 'Janakpuri B-Block', boardedTime: '--', status: 'Absent', parent: 'Anil Kapoor', phone: '+91 98555 66778'),
          StudentPassenger(name: 'Diya Patel', studentClass: 'Class 9-A', stop: 'Vikaspuri More', boardedTime: '07:44 AM', status: 'Boarded', parent: 'Kirit Patel', phone: '+91 98444 55667'),
          StudentPassenger(name: 'Aditya Verma', studentClass: 'Class 8-B', stop: 'Dwarka Sec 12', boardedTime: '07:05 AM', status: 'Boarded', parent: 'Sunil Verma', phone: '+91 98777 11223'),
        ],
        fuelLogs: const [
          FuelLogEntry(id: 'fl_01', date: '26 Aug 2026', busNumber: 'DL 01 PB 4488', litres: '65 L Diesel', cost: '₹ 5,825', odometer: '48,250 KM', fuelPump: 'IOCL Sec 10', referenceNumber: 'IOCL_8841'),
          FuelLogEntry(id: 'fl_02', date: '19 Aug 2026', busNumber: 'DL 01 PB 4488', litres: '70 L Diesel', cost: '₹ 6,270', odometer: '47,910 KM', fuelPump: 'IOCL Sec 10', referenceNumber: 'IOCL_8790'),
          FuelLogEntry(id: 'fl_03', date: '12 Aug 2026', busNumber: 'DL 01 PB 4488', litres: '68 L Diesel', cost: '₹ 6,090', odometer: '47,580 KM', fuelPump: 'IOCL Sec 10', referenceNumber: 'IOCL_8712'),
        ],
      ),
      VehicleFleetInfo(
        id: 'vh_02',
        busNumber: 'DL 01 PB 9921 (Bus 07)',
        model: 'Ashok Leyland Sunshine (36-Seater)',
        capacity: 36,
        routeName: 'Route 07: Rohini Sec 15 to School Campus',
        totalStops: 12,
        totalScholars: 34,
        onboardToday: 33,
        absentToday: 1,
        driverName: 'Mr. Baljit Singh',
        driverPhone: '+91 98333 77889',
        driverLicense: 'DL-0320147712 (Commercial HMV • Verified)',
        attendantName: 'Mr. Satish Kumar',
        attendantPhone: '+91 98444 88990',
        liveStatus: 'Arrived at Campus',
        currentSpeed: '0 km/h (Bay 3)',
        currentLocation: 'Campus Gate 2 Parking Bay 3',
        etaToSchool: '0 min (Arrived)',
        lastFuelDate: '25 Aug 2026',
        lastFuelQuantity: '60 Litres Diesel',
        lastFuelCost: '₹ 5,377.20',
        fuelMileage: '5.1 KM/L',
        lastServiceDate: '05 Aug 2026 (Regular 40K)',
        nextServiceDate: '05 Nov 2026 (in 67 days)',
        fitnessExpiry: '20 April 2027 (Valid)',
        insuranceExpiry: '15 Dec 2026 (HDFC ERGO)',
        pucExpiry: '10 Jan 2027 (Valid)',
        routeStops: const [
          RouteStopInfo(stopName: 'Rohini Sec 15', scheduledTime: '07:00 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Pitampura Metro', scheduledTime: '07:20 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Punjabi Bagh Club', scheduledTime: '07:35 AM', isCompleted: true),
          RouteStopInfo(stopName: 'School Campus', scheduledTime: '07:55 AM', isCompleted: true, isCurrent: true),
        ],
        studentsOnboard: const [
          StudentPassenger(name: 'Sneha Kulkarni', studentClass: 'Class 10-A', stop: 'Pitampura Metro', boardedTime: '07:22 AM', status: 'Boarded', parent: 'Madhav Kulkarni', phone: '+91 98666 77889'),
          StudentPassenger(name: 'Manish Tyagi', studentClass: 'Class 11-Com', stop: 'Rohini Sec 15', boardedTime: '07:04 AM', status: 'Boarded', parent: 'Alok Tyagi', phone: '+91 98777 88990'),
          StudentPassenger(name: 'Tanya Sengupta', studentClass: 'Class 12-Arts', stop: 'Punjabi Bagh Club', boardedTime: '--', status: 'Absent', parent: 'Subhash Sengupta', phone: '+91 98111 99001'),
        ],
        fuelLogs: const [
          FuelLogEntry(id: 'fl_04', date: '25 Aug 2026', busNumber: 'DL 01 PB 9921', litres: '60 L Diesel', cost: '₹ 5,377', odometer: '39,400 KM', fuelPump: 'HPCL Rohini', referenceNumber: 'HPCL_4412'),
          FuelLogEntry(id: 'fl_05', date: '18 Aug 2026', busNumber: 'DL 01 PB 9921', litres: '62 L Diesel', cost: '₹ 5,550', odometer: '39,080 KM', fuelPump: 'HPCL Rohini', referenceNumber: 'HPCL_4380'),
        ],
      ),
      VehicleFleetInfo(
        id: 'vh_03',
        busNumber: 'DL 01 PB 1102 (Bus 02)',
        model: 'Force Traveller Mini Bus (26-Seater)',
        capacity: 26,
        routeName: 'Route 02: Vasant Kunj to School Campus',
        totalStops: 10,
        totalScholars: 24,
        onboardToday: 24,
        absentToday: 0,
        driverName: 'Mr. Devendra Sharma',
        driverPhone: '+91 98555 99001',
        driverLicense: 'DL-0920193341 (Commercial HMV • Verified)',
        attendantName: 'Mr. Jagdish Prasad',
        attendantPhone: '+91 98666 00112',
        liveStatus: 'In Transit • GPS Active',
        currentSpeed: '28 km/h',
        currentLocation: 'Near Munirka D-Block Light',
        etaToSchool: '11 mins',
        lastFuelDate: '27 Aug 2026',
        lastFuelQuantity: '45 Litres CNG / Diesel',
        lastFuelCost: '₹ 3,960.00',
        fuelMileage: '6.2 KM/L',
        lastServiceDate: '20 June 2026',
        nextServiceDate: '20 Sept 2026 (in 21 days)',
        fitnessExpiry: '10 June 2027 (Valid)',
        insuranceExpiry: '10 Oct 2026 (Due Soon)',
        pucExpiry: '15 Dec 2026 (Valid)',
        routeStops: const [
          RouteStopInfo(stopName: 'Vasant Kunj B-4', scheduledTime: '07:10 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Mahipalpur Chowk', scheduledTime: '07:25 AM', isCompleted: true),
          RouteStopInfo(stopName: 'Munirka D-Block', scheduledTime: '07:40 AM', isCompleted: false, isCurrent: true),
          RouteStopInfo(stopName: 'IIT Gate', scheduledTime: '07:48 AM', isCompleted: false),
          RouteStopInfo(stopName: 'School Campus', scheduledTime: '08:00 AM', isCompleted: false),
        ],
        studentsOnboard: const [
          StudentPassenger(name: 'Pooja Hegde', studentClass: 'Class 9-B', stop: 'Vasant Kunj B-4', boardedTime: '07:12 AM', status: 'Boarded', parent: 'Kiran Hegde', phone: '+91 98444 11223'),
          StudentPassenger(name: 'Samar Singhania', studentClass: 'Class 10-B', stop: 'Mahipalpur Chowk', boardedTime: '07:26 AM', status: 'Boarded', parent: 'Vikram Singhania', phone: '+91 98555 22334'),
        ],
        fuelLogs: const [
          FuelLogEntry(id: 'fl_06', date: '27 Aug 2026', busNumber: 'DL 01 PB 1102', litres: '45 L CNG', cost: '₹ 3,960', odometer: '28,150 KM', fuelPump: 'IGL Vasant Kunj', referenceNumber: 'IGL_9912'),
        ],
      ),
    ];
  }
}
