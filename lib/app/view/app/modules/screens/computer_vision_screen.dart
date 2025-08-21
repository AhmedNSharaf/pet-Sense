import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';



class PetDiseaseScreen extends StatefulWidget {
  @override
  _PetDiseaseScreenState createState() => _PetDiseaseScreenState();
}

class _PetDiseaseScreenState extends State<PetDiseaseScreen> {
  File? _selectedImage;
  bool _isLoading = false;
  String? _result;
  String? _error;
  final ImagePicker _picker = ImagePicker();
  
  // ضع رابط الـ API الخاص بك هنا
  final String apiUrl = "https://ahmed1122003-pet-disease-api.hf.space/predict";

  // اختيار صورة من المعرض
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _result = null;
          _error = null;
        });
      }
    } catch (e) {
      setState(() {
        _error = "خطأ في اختيار الصورة: $e";
      });
    }
  }

  // اختيار صورة من الكاميرا
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _result = null;
          _error = null;
        });
      }
    } catch (e) {
      setState(() {
        _error = "خطأ في التقاط الصورة: $e";
      });
    }
  }

  // إرسال الصورة إلى API
  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      setState(() {
        _error = "الرجاء اختيار صورة أولاً";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _result = null;
    });

    try {
      // إنشاء multipart request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      
      // إضافة الصورة إلى الطلب
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _selectedImage!.path,
        ),
      );

      print("إرسال الطلب إلى: $apiUrl");
      
      // إرسال الطلب مع timeout
      var streamedResponse = await request.send().timeout(
        Duration(seconds: 60),
      );
      
      // الحصول على الرد
      var response = await http.Response.fromStream(streamedResponse);
      
      print("كود الاستجابة: ${response.statusCode}");
      print("نص الاستجابة: ${response.body}");

      if (response.statusCode == 200) {
        // محاولة تحويل الرد إلى JSON
        try {
          var jsonResponse = json.decode(response.body);
          setState(() {
            _result = _formatResponse(jsonResponse);
          });
        } catch (e) {
          // إذا لم يكن JSON، عرض النص الخام
          setState(() {
            _result = response.body;
          });
        }
      } else {
        setState(() {
          _error = "خطأ من الخادم: ${response.statusCode}\n${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _error = "خطأ في الشبكة: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // تنسيق الرد من API
  String _formatResponse(dynamic jsonResponse) {
    if (jsonResponse is Map<String, dynamic>) {
      String formatted = "نتيجة التشخيص:\n\n";
      jsonResponse.forEach((key, value) {
        formatted += "$key: $value\n";
      });
      return formatted;
    } else if (jsonResponse is List) {
      return "النتائج:\n\n${jsonResponse.join('\n')}";
    } else {
      return jsonResponse.toString();
    }
  }

  // إظهار خيارات اختيار الصورة
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('اختيار من المعرض'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('التقاط صورة'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('إلغاء'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تشخيص أمراض الحيوانات الأليفة'),
        backgroundColor: Colors.blue[600],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // منطقة عرض الصورة
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pets,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'لم يتم اختيار صورة',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            
            SizedBox(height: 20),
            
            // أزرار التحكم
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showImageSourceDialog,
                    icon: Icon(Icons.image),
                    label: Text('اختيار صورة'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _selectedImage != null && !_isLoading 
                        ? _uploadImage 
                        : null,
                    icon: _isLoading 
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(Icons.cloud_upload),
                    label: Text(_isLoading ? 'جاري التحليل...' : 'تحليل الصورة'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // عرض النتائج أو الأخطاء
            if (_error != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'خطأ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      _error!,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                  ],
                ),
              ),
            
            if (_result != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  border: Border.all(color: Colors.green[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          'النتيجة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      _result!,
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}