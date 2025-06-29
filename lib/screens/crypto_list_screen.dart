import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:retrofitsample/api/api_client.dart';
import 'package:retrofitsample/model/crytocurrency.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  late ApiClient _apiClient;
  List<CryptoCurrency> _cryptoCurrencies = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeApiClient();
    _loadCryptoCurrencies();
  }

  void _initializeApiClient() {
    final dio = Dio();
    // Add API key to headers if required
    dio.options.headers['Authorization'] =
        'Bearer 305ae7fa2f751acd65d11e950bbbec3f5b7608b7858b62f04b43de441e967adb';
    _apiClient = ApiClient(dio);
  }

  Future<void> _loadCryptoCurrencies() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _apiClient.getCryptoCurrencies();

      setState(() {
        _cryptoCurrencies = response.data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _error = 'Failed to load cryptocurrencies: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptocurrency List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCryptoCurrencies,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[700]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCryptoCurrencies,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_cryptoCurrencies.isEmpty) {
      return const Center(child: Text('No cryptocurrencies found'));
    }

    return RefreshIndicator(
      onRefresh: _loadCryptoCurrencies,
      child: ListView.builder(
        itemCount: _cryptoCurrencies.length,
        itemBuilder: (context, index) {
          final crypto = _cryptoCurrencies[index];
          return _buildCryptoCard(crypto);
        },
      ),
    );
  }

  Widget _buildCryptoCard(CryptoCurrency crypto) {
    final priceChange = double.tryParse(crypto.changePercent24Hr) ?? 0.0;
    final isPositive = priceChange >= 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crypto.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        crypto.symbol.toUpperCase(),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${double.tryParse(crypto.priceUsd)?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPositive ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? Colors.green[700]
                              : Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem('Rank', '#${crypto.rank}'),
                _buildInfoItem(
                  'Market Cap',
                  '\$${_formatNumber(crypto.marketCapUsd)}',
                ),
                _buildInfoItem(
                  'Volume (24h)',
                  '\$${_formatNumber(crypto.volumeUsd24Hr)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  String _formatNumber(String numberStr) {
    final number = double.tryParse(numberStr);
    if (number == null) return '0';

    if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}M';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(2);
    }
  }
}
