// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Money Logger';

  @override
  String get navDashboard => 'Tổng quan';

  @override
  String get navTransactions => 'Giao dịch';

  @override
  String get navAddTransaction => 'Thêm giao dịch';

  @override
  String get navBudgets => 'Ngân sách';

  @override
  String get navProfile => 'Hồ sơ';

  @override
  String get purposeDashboard => 'Tổng quan tài chính và hoạt động gần đây';

  @override
  String get purposeTransactions => 'Lịch sử thu chi hàng tháng';

  @override
  String get purposeAddTransaction => 'Tạo khoản thu hoặc chi';

  @override
  String get purposeBudgets => 'Hạn mức chi tiêu và ngân sách theo danh mục';

  @override
  String get purposeProfile => 'Tài khoản, tùy chọn, bảo mật và giao diện';

  @override
  String get startEntry => 'Bắt đầu tạo khoản thu hoặc chi mới.';

  @override
  String destinationItem(Object destination, Object index) {
    return 'Mục $index của $destination';
  }

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get enabled => 'Bật';

  @override
  String get disabled => 'Tắt';

  @override
  String get light => 'Sáng';

  @override
  String get dark => 'Tối';

  @override
  String get toggle => 'Đổi chế độ';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get english => 'Tiếng Anh (Mỹ)';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get recentTransactions => 'Giao dịch gần đây';

  @override
  String get viewAll => 'Xem tất cả';

  @override
  String get noTransactions => 'Chưa có giao dịch';

  @override
  String get recentActivityEmpty => 'Hoạt động gần đây sẽ hiển thị tại đây.';

  @override
  String get currentBalance => 'Số dư hiện tại';

  @override
  String get balanceHidden => 'Đã ẩn số dư';

  @override
  String get hideBalance => 'Ẩn số dư';

  @override
  String get showBalance => 'Hiện số dư';

  @override
  String get noMonthTransactions => 'Không có giao dịch nào trong tháng này.';

  @override
  String dailyTotal(Object amount) {
    return 'Tổng trong ngày: $amount';
  }

  @override
  String get dashboard => 'Tổng quan';

  @override
  String get transactions => 'Giao dịch';

  @override
  String get back => 'Quay lại';

  @override
  String get save => 'Lưu';

  @override
  String get addTransactionForm => 'Biểu mẫu thêm giao dịch';

  @override
  String get amount => 'Số tiền';

  @override
  String get amountHintUsd => '0,00';

  @override
  String get amountHintVnd => '0';

  @override
  String get enterAmountError => 'Nhập số tiền lớn hơn 0.';

  @override
  String get selectCategory => 'Chọn danh mục';

  @override
  String get selectCategoryError => 'Hãy chọn danh mục.';

  @override
  String get categoryTypeError =>
      'Loại danh mục không khớp với loại giao dịch.';

  @override
  String get dateTime => 'Ngày và giờ';

  @override
  String get moreDetails => 'Chi tiết khác';

  @override
  String get addEvent => 'Thêm sự kiện hoặc chiến dịch';

  @override
  String get eventCampaign => 'Sự kiện hoặc chiến dịch';

  @override
  String get noEvent => 'Không có sự kiện';

  @override
  String get holidaySpending => 'Chi tiêu dịp lễ';

  @override
  String get homeRenovation => 'Sửa sang nhà cửa';

  @override
  String get birthdayCelebration => 'Mừng sinh nhật';

  @override
  String get expense => 'Chi';

  @override
  String get income => 'Thu';

  @override
  String get noCategories => 'Chưa có danh mục';

  @override
  String get noCategoriesType => 'Không có danh mục cho loại này';

  @override
  String get selected => 'đã chọn';

  @override
  String get neutral => 'Trung tính';

  @override
  String get categoryFuel => 'Nhiên liệu';

  @override
  String get categoryTransportation => 'Đi lại';

  @override
  String get categoryFoodAndBeverage => 'Ăn uống';

  @override
  String get categoryRent => 'Tiền thuê nhà';

  @override
  String get categoryLending => 'Cho vay';

  @override
  String get categoryDebtRepayment => 'Trả nợ';

  @override
  String get categoryVehicleRepair => 'Sửa xe';

  @override
  String get categoryPhoneBills => 'Cước điện thoại';

  @override
  String get categoryHaircut => 'Cắt tóc';

  @override
  String get categoryHealthcare => 'Chăm sóc sức khỏe';

  @override
  String get categoryEntertainmentAndLeisure => 'Giải trí';

  @override
  String get categoryOtherExpenses => 'Chi phí khác';

  @override
  String get categoryOnlineServices => 'Dịch vụ trực tuyến';

  @override
  String get categoryShopping => 'Mua sắm';

  @override
  String get categoryTransferOut => 'Chuyển tiền đi';

  @override
  String get categoryGifts => 'Quà tặng';

  @override
  String get categoryVehicleMaintenance => 'Bảo dưỡng xe';

  @override
  String get categoryPersonalCare => 'Chăm sóc cá nhân';

  @override
  String get categoryTransferIn => 'Chuyển tiền đến';

  @override
  String get categorySalary => 'Lương';

  @override
  String get categoryOtherIncome => 'Thu nhập khác';

  @override
  String get categoryGiftsReceived => 'Quà được tặng';

  @override
  String get categoryBorrowing => 'Đi vay';

  @override
  String get categoryDebtCollection => 'Thu hồi nợ';
}

/// The translations for Vietnamese, as used in Viet Nam (`vi_VN`).
class AppLocalizationsViVn extends AppLocalizationsVi {
  AppLocalizationsViVn() : super('vi_VN');

  @override
  String get appTitle => 'Money Logger';

  @override
  String get navDashboard => 'Tổng quan';

  @override
  String get navTransactions => 'Giao dịch';

  @override
  String get navAddTransaction => 'Thêm giao dịch';

  @override
  String get navBudgets => 'Ngân sách';

  @override
  String get navProfile => 'Hồ sơ';

  @override
  String get purposeDashboard => 'Tổng quan tài chính và hoạt động gần đây';

  @override
  String get purposeTransactions => 'Lịch sử thu chi hàng tháng';

  @override
  String get purposeAddTransaction => 'Tạo khoản thu hoặc chi';

  @override
  String get purposeBudgets => 'Hạn mức chi tiêu và ngân sách theo danh mục';

  @override
  String get purposeProfile => 'Tài khoản, tùy chọn, bảo mật và giao diện';

  @override
  String get startEntry => 'Bắt đầu tạo khoản thu hoặc chi mới.';

  @override
  String destinationItem(Object destination, Object index) {
    return 'Mục $index của $destination';
  }

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get enabled => 'Bật';

  @override
  String get disabled => 'Tắt';

  @override
  String get light => 'Sáng';

  @override
  String get dark => 'Tối';

  @override
  String get toggle => 'Đổi chế độ';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get english => 'Tiếng Anh (Mỹ)';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get recentTransactions => 'Giao dịch gần đây';

  @override
  String get viewAll => 'Xem tất cả';

  @override
  String get noTransactions => 'Chưa có giao dịch';

  @override
  String get recentActivityEmpty => 'Hoạt động gần đây sẽ hiển thị tại đây.';

  @override
  String get currentBalance => 'Số dư hiện tại';

  @override
  String get balanceHidden => 'Đã ẩn số dư';

  @override
  String get hideBalance => 'Ẩn số dư';

  @override
  String get showBalance => 'Hiện số dư';

  @override
  String get noMonthTransactions => 'Không có giao dịch nào trong tháng này.';

  @override
  String dailyTotal(Object amount) {
    return 'Tổng trong ngày: $amount';
  }

  @override
  String get dashboard => 'Tổng quan';

  @override
  String get transactions => 'Giao dịch';

  @override
  String get back => 'Quay lại';

  @override
  String get save => 'Lưu';

  @override
  String get addTransactionForm => 'Biểu mẫu thêm giao dịch';

  @override
  String get amount => 'Số tiền';

  @override
  String get amountHintUsd => '0,00';

  @override
  String get amountHintVnd => '0';

  @override
  String get enterAmountError => 'Nhập số tiền lớn hơn 0.';

  @override
  String get selectCategory => 'Chọn danh mục';

  @override
  String get selectCategoryError => 'Hãy chọn danh mục.';

  @override
  String get categoryTypeError =>
      'Loại danh mục không khớp với loại giao dịch.';

  @override
  String get dateTime => 'Ngày và giờ';

  @override
  String get moreDetails => 'Chi tiết khác';

  @override
  String get addEvent => 'Thêm sự kiện hoặc chiến dịch';

  @override
  String get eventCampaign => 'Sự kiện hoặc chiến dịch';

  @override
  String get noEvent => 'Không có sự kiện';

  @override
  String get holidaySpending => 'Chi tiêu dịp lễ';

  @override
  String get homeRenovation => 'Sửa sang nhà cửa';

  @override
  String get birthdayCelebration => 'Mừng sinh nhật';

  @override
  String get expense => 'Chi';

  @override
  String get income => 'Thu';

  @override
  String get noCategories => 'Chưa có danh mục';

  @override
  String get noCategoriesType => 'Không có danh mục cho loại này';

  @override
  String get selected => 'đã chọn';

  @override
  String get neutral => 'Trung tính';

  @override
  String get categoryFuel => 'Nhiên liệu';

  @override
  String get categoryTransportation => 'Đi lại';

  @override
  String get categoryFoodAndBeverage => 'Ăn uống';

  @override
  String get categoryRent => 'Tiền thuê nhà';

  @override
  String get categoryLending => 'Cho vay';

  @override
  String get categoryDebtRepayment => 'Trả nợ';

  @override
  String get categoryVehicleRepair => 'Sửa xe';

  @override
  String get categoryPhoneBills => 'Cước điện thoại';

  @override
  String get categoryHaircut => 'Cắt tóc';

  @override
  String get categoryHealthcare => 'Chăm sóc sức khỏe';

  @override
  String get categoryEntertainmentAndLeisure => 'Giải trí';

  @override
  String get categoryOtherExpenses => 'Chi phí khác';

  @override
  String get categoryOnlineServices => 'Dịch vụ trực tuyến';

  @override
  String get categoryShopping => 'Mua sắm';

  @override
  String get categoryTransferOut => 'Chuyển tiền đi';

  @override
  String get categoryGifts => 'Quà tặng';

  @override
  String get categoryVehicleMaintenance => 'Bảo dưỡng xe';

  @override
  String get categoryPersonalCare => 'Chăm sóc cá nhân';

  @override
  String get categoryTransferIn => 'Chuyển tiền đến';

  @override
  String get categorySalary => 'Lương';

  @override
  String get categoryOtherIncome => 'Thu nhập khác';

  @override
  String get categoryGiftsReceived => 'Quà được tặng';

  @override
  String get categoryBorrowing => 'Đi vay';

  @override
  String get categoryDebtCollection => 'Thu hồi nợ';
}
